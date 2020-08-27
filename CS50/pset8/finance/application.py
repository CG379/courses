import os

from cs50 import SQL
from flask import Flask, flash, jsonify, redirect, render_template, request, session
from flask_session import Session
from tempfile import mkdtemp
from werkzeug.exceptions import default_exceptions, HTTPException, InternalServerError
from werkzeug.security import check_password_hash, generate_password_hash

from helpers import apology, login_required, lookup, usd
import re

# Configure application
app = Flask(__name__)

# Ensure templates are auto-reloaded
app.config["TEMPLATES_AUTO_RELOAD"] = True

# Ensure responses aren't cached
@app.after_request
def after_request(response):
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    response.headers["Expires"] = 0
    response.headers["Pragma"] = "no-cache"
    return response

# Custom filter
app.jinja_env.filters["usd"] = usd

# Configure session to use filesystem (instead of signed cookies)
app.config["SESSION_FILE_DIR"] = mkdtemp()
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
Session(app)

# Configure CS50 Library to use SQLite database
db = SQL("sqlite:///finance.db")

# Make sure API key is set
if not os.environ.get("API_KEY"): # TODO
    raise RuntimeError("API_KEY not set")


@app.route("/")
@login_required
def index():
    """Show portfolio of stocks"""
    rows = db.execute("SELECT * FROM stocks WHERE user_id = :user", user=session["user_id"])
    cash = db.execute("SELECT cash FROM users WHERE id = :user", user=session["user_id"])[0]['cash']
    total = cash
    stocks = []
    for index, row in enumerate(rows):
        stock_info = lookup(row['symbol'])
        stocks.append(list((stock_info['symbol'], stock_info['name'], row['amount'], stock_info['price'], round(stock_info['price'] * row['amount'], 2))))
        total += stocks[index][4]
    return render_template("index.html", stocks=stocks, cash=round(cash, 2), total=round(total, 2))


@app.route("/buy", methods=["GET", "POST"])
@login_required
def buy():
    """Buy shares of stock"""

    # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":
        # Obtain the data necessary for the transaction
        amount=int(request.form.get("amount"))
        symbol=lookup(request.form.get("symbol"))['symbol']
        # Control if the stock symbol is valid
        if not lookup(symbol):
            return apology("Could not find the stock")
        price=lookup(symbol)['price']
        cash = db.execute("SELECT cash FROM users WHERE id = :user",
                          user=session["user_id"])[0]['cash']
        cash_after = cash - price * float(amount)
        # Check if current cash is enough for transaction
        if cash_after < 0:
            return apology("You don't have enough money for this transaction")
        stock = db.execute("SELECT amount FROM stocks WHERE user_id = :user AND symbol = :symbol",
                          user=session["user_id"], symbol=symbol)
        if not stock:
            db.execute("INSERT INTO stocks(user_id, symbol, amount) VALUES (:user, :symbol, :amount)",
                user=session["user_id"], symbol=symbol, amount=amount)
        # update row into the stock table
        else:
            amount += stock[0]['amount']
            db.execute("UPDATE stocks SET amount = :amount WHERE user_id = :user AND symbol = :symbol",
                user=session["user_id"], symbol=symbol, amount=amount)
        db.execute("UPDATE users SET cash = :cash WHERE id = :user",
                          cash=cash_after, user=session["user_id"])
        db.execute("INSERT INTO transactions(user_id, symbol, amount, value) VALUES (:user, :symbol, :amount, :value)",
                user=session["user_id"], symbol=symbol, amount=amount, value=round(price*float(amount)))
        flash("Stock Successfully Bought!")
        return redirect("/")

    # User reached route via GET (as by clicking a link or via redirect)
    else:
        return render_template("buy.html")

@app.route("/history")
@login_required
def history():
    """Show history of transactions"""
    rows = db.execute("SELECT * FROM transactions WHERE user_id = :user", user=session["user_id"])
    transactions = []
    for row in rows:
        stock_info = lookup(row['symbol'])
    transactions.append(list((stock_info['symbol'], stock_info['name'], row['amount'], row['value'], row['date'])))
    return render_template("history.html", transactions=transactions)


@app.route("/login", methods=["GET", "POST"])
def login():
    """Log user in"""
    # Forget any user_id (needed for some reason)
    session.clear()
    # if reached by POST
    if request.method == "POST":
        # Ensure username was submitted
        if not request.form.get("username"):
            return apology("must provide username")
        # Ensure password was submitted
        elif not request.form.get("password"):
            return apology("must provide password")
        # Check if there isnt already someone with the smae username
        rows = db.execute("SELECT * FROM users WHERE username = :username",
                          username=request.form.get("username"))
        # Ensure username exists and password is correct
        if len(rows) != 1 or not check_password_hash(rows[0]["hash"], request.form.get("password")):
            return apology("invalid username and/or password")
        # Remember which user has logged in
        session["user_id"] = rows[0]["id"]
        # Redirect to home page
        return redirect("/")

    # if reached by GET (as by clicking a link or via redirect)
    else:
        return render_template("login.html")


@app.route("/logout")
def logout():
    """Log user out"""

    # Forget any user_id
    session.clear()

    # Redirect user to login form
    return redirect("/")


@app.route("/quote", methods=["GET", "POST"])
@login_required
def quote():
    """Get stock quote."""
    # If the user wants a stock quote
    if request.method == "POST":
        stock = lookup(request.form.get("symbol"))
        if not stock:
            return apology("Could not find stock")
        return render_template("quote.html", stock = stock)
    # If the user was redirected to quote page
    else:
        return render_template("quote.html", stock = "")


@app.route("/register", methods=["GET", "POST"])
def register():
    session.clear()
    if request.method == "POST":
        symbol = re.compile('[@_!#$%^&*()<>?/\|}{~:]')
        number = re.compile('1234567890')
        # Checks if the username, password and password confirmation field has been filled
        if not request.form.get("username"):
            return apology("Please provide a username")
        elif not request.form.get("password"):
            return apology("Please provide a password")
        elif request.form.get("password") != request.form.get("confirmation"):
            return apology("Passwords must match")
        #Checks for numbers and special characters
        elif (symbol.search(request.form.get("password")) or number.search(request.form.get("password"))) == None:
            return apology("Password must contain at least one number and special character.")
        # Checks if the usename is already taken
        elif db.execute("SELECT * FROM users WHERE username = :username", username = request.form.get("userneme")):
            return apology("Username already taken. Please choose a different username.")
        # Saves the username and the hahsed password
        db.execute("INSERT INTO users(username, hash) VALUES (:username, :hashpw)", username = request.form.get("username"),
        hashpw = generate_password_hash(request.form.get("password")))
        # gets the username from the database
        rows = db.execute("SELECT * FROM users WHERE username = :username", username = request.form.get("username"))
        # assigns a session to the user

        session["user_id"] = rows[0]["id"]
        return redirect("/")
    else:
        return render_template("register.html")


@app.route("/sell", methods=["GET", "POST"])
@login_required
def sell():
    """Sell shares of stock"""
    if request.method == "POST":
        # Get the info needed for the transactions
        amount = int(request.form.get("amount"))
        symbol = request.form.get("symbol")
        price = lookup(symbol)["price"]
        value = round(price * float(amount))
        # Update the stock table
        amountBefore = db.execute("SELECT amount FROM stocks WHERE user_id = :user AND symbol = :symbol", symbol=symbol,
        user=session["user_id"])[0]['amount']
        amountAfter = amountBefore - amount
        # Delete the table if there are no owned stocks
        if amountAfter == 0:
            db.execute("DELETE FROM stocks WHERE user_id = :user AND symbol = :symbol", symbol=symbol, user=session["user_id"])
        # If the user wants to sell more stocks than they own
        elif amountAfter < 0:
            return apology("That excedes the amount of stocks you own.")
        else:
            db.execute("UPDATE stocks SET amount = :amount WHERE user_id = :user AND symbol = :symbol", symbol=symbol,
            user=session["user_id"], amount=amountAfter)
        # Update user's cash
        cash = db.execute("SELECT cash FROM users WHERE id = :user",
        user=session["user_id"])[0]['cash']
        cashAfter = cash + price * float(amount)
        db.execute("UPDATE users SET cash = :cash WHERE id = :user",
        cash=cashAfter, user=session["user_id"])
        # Update history
        db.execute("INSERT INTO transactions(user_id, symbol, amount, value) VALUES (:user, :symbol, :amount, :value)",
        user=session["user_id"], symbol=symbol, amount=-amount, value=value)
        flash("Stock Successfully Sold!")
        return redirect("/")
    else:
        rows = db.execute("SELECT symbol, amount FROM stocks WHERE user_id = :user",user=session["user_id"])
        stocks = {}
        for row in rows:
            stocks[row['symbol']] = row['amount']
        return render_template("sellStocks.html", stocks=stocks)


def errorhandler(e):
    """Handle error"""
    if not isinstance(e, HTTPException):
        e = InternalServerError()
    return apology(e.name, e.code)


# Listen for errors
for code in default_exceptions:
    app.errorhandler(code)(errorhandler)
