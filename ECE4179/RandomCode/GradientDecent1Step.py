import numpy as np

def sigmoid(x):
    return 1 / (1 + np.exp(-x))

def lin(x,w,b):
    return w*x + b

def huber_loss(y_true, y_pred, delta=1.0):
    error = y_pred - y_true
    is_small_error = np.abs(error) <= delta
    squared_loss = np.square(error) / 2
    linear_loss = delta * (np.abs(error) - delta / 2)
    return np.where(is_small_error, squared_loss, linear_loss)

# input dependent
def huber_gradient(y_true, y_pred, delta=1.0):
    error = y_pred - y_true
    is_small_error = np.abs(error) <= delta
    grad = np.where(is_small_error, np.square(y_pred)*(1-y_pred), y_pred*(1-y_pred))
    return grad

# Data
X = np.array([[1.5, 0.5], [-0.5, 1.5]])
y = np.array([0, 3])

# Initial weight
w = 1

# Learning rate
eta = 1

# Forward pass
z = w * X[:, 0]+ w*X[:, 1] + 2 * X[:, 1] 
y_pred = sigmoid(z)

# Compute loss
loss = np.mean(huber_loss(y, y_pred))

# Compute gradient
grad1 = huber_gradient(y[0], y_pred[0], 1)
grad2 = huber_gradient(y[1], y_pred[1], 1)
print(min(grad1,grad2)==grad1)
grad = np.mean([grad1, grad2])

# Update weight
w_new = w - eta * grad

print(f"Initial w: {w}")
print(f"Loss: {loss}")
print(f"Gradient: {grad}")
print(f"Updated w: {w_new:.4f}")


wb = np.array([[1,2,1], [1, 1,2]])

grad_w = -3*wb[0,:] + 20*wb[1,:] + 10
grad_b = -2*wb[0,:] + 5*wb[1,:] + 17
grad_both = (grad_w+grad_b)/2

print(grad_w)
print(grad_b)
print(grad_both)


x = np.array([0.5, 1.5, -0.5])

w3 = np.array([1,-1,2,1,2,-2])
b3 = np.array([0.5,1.5])

a = x[0]*w3[0]+x[1]*w3[1] + b3[0]
b = x[1]*w3[2]+x[2]*w3[4] + b3[0]
a = w3[4]*np.tanh(a)
b = w3[5]*np.tanh(b)
out = sigmoid(a+b+b3[1])
print(out)


def relu(x):
    return np.maximum(0, x)

def relu_derivative(x):
    return (x > 0).astype(float)

# Define the input and weights
x = np.array([-2, 1])
W = np.array([[-1, 3], [4, 4]])

# Forward pass
Wx = np.dot(W, x)
y_hat = relu(Wx)

# Given gradient of loss with respect to output
grad_y_hat = np.array([5, -1])

# Backpropagation
grad_Wx = grad_y_hat * relu_derivative(Wx)
grad_W = np.outer(grad_Wx, x)

# Print results
print("W:")
print(W)
print("\nx:")
print(x)
print("\nWx:")
print(Wx)
print("\ny_hat (after ReLU):")
print(y_hat)
print("\ngrad_y_hat:")
print(grad_y_hat)
print("\ngrad_Wx (after ReLU derivative):")
print(grad_Wx)
print("\ngrad_W (before rounding):")
print(grad_W)
print("\ngrad_W (rounded to nearest whole number):")
print(np.round(grad_W).astype(int))



w1= -0.8
w2= -0.1
w3= -0.7
w4= 0.4
w5= -0.1
w6= -0.6
w7= -0.8
w8= 0.3
w9= 0.8

x1=0.8
x2=0.1

rel1 = relu(x1*w1+x2*w2)
rel2 = relu(x1*w3+x2*w4)
rel3 = relu(x1*w5+x2*w6)

y_final = sigmoid(rel1*w7+rel2*w8+rel3*w9)
print(y_final, x1*w1+x2*w2,x1*w3+x2*w4,x1*w5+x2*w6)

# Define the logits
logits = np.array([-5.5, 7.4, 7.0, 6.3, -5.0])

# True class index for "frog"
true_class_index = 3  # Assuming "frog" is at index 3

# Function to compute softmax
def softmax(x):
    e_x = np.exp(x - np.max(x))  # Subtract max for numerical stability
    return e_x / e_x.sum()

# Compute softmax probabilities
softmax_probs = softmax(logits)

# Compute the negative log-likelihood loss
# We use log of the probability corresponding to the true class
negative_log_likelihood = -np.log(softmax_probs[true_class_index])

# Round to two decimal places
negative_log_likelihood = round(negative_log_likelihood, 2)

print(f"The softmax probabilities are: {softmax_probs}")
print(f"The negative log-likelihood loss for this sample is: {negative_log_likelihood}")

x = np.array([35,29,33,30,28])
y = np.array([96,82,91,84,79])

from sklearn.linear_model import LinearRegression
x = x.reshape(-1, 1)
model = LinearRegression()
model.fit(x, y)

slope = model.coef_[0]
intercept = model.intercept_

print(f"Slope: {slope}")
print(f"Intercept: {intercept}")
print(slope*6+intercept)
