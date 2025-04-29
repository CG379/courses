import numpy as np
import matplotlib.pyplot as plt

from ipywidgets import Play, IntSlider, jslink, Button, interact, HBox

from sklearn.metrics import accuracy_score, precision_score, recall_score




#=======================================================================================================================
# A helper function to plot the tangent line at a specific point x0
def plot_tangent(f, df_dx, x0, delta=0.5):
    """
    Plots the tangent line of a function f at a point x0
    :param f: function
    :param df_dx: derivative of the function f
    :param x0: point where the tangent line will be plotted
    :param delta: defines the length of the tangent line
    :return: None
    """

    y0 = f(x0)  # Compute the value of the function at x0
    slope = df_dx(x0)  # Compute the slope of the tangent at x0
    x_tangent = [x0 - delta, x0 + delta]  # x-coordinates of tangent endpoints
    y_tangent = [y0 - slope * delta, y0 + slope * delta]  # y-coordinates of tangent endpoints
    plt.plot(x_tangent, y_tangent, linestyle='--', c='black', label=f'Tangent at x={x0}')  # Plot the tangent line



#=======================================================================================================================
# A helper function to plot the history of gradient descent

def plot_history(x, func, x_star, hist_gd):
    """
    Plot the function and the history of gradient descent
    """

    hist_f = hist_gd["hist_f"]
    hist_x = hist_gd["hist_x"]

    plt.figure(figsize=(10, 5))

    f_x = func(x)
    f_x_star = func(x_star)

    # Plot the function first to ensure it is in the background
    plt.plot(x, f_x, color="blue", label='f(x)', zorder=1)
    plt.plot(x_star, f_x_star, 'r*', markersize=10, label='x*', zorder=2)
    plt.axvline(x_star, linestyle='--', color='r', label='x*', zorder=3)

    # Plot arrows, text labels, and circles with higher zorder to ensure they are above the line plot
    for i in range(len(hist_x) - 1):
        dx = hist_x[i+1] - hist_x[i]
        dy = hist_f[i+1] - hist_f[i]
        plt.annotate('', xy=(hist_x[i+1], hist_f[i+1]), xytext=(hist_x[i], hist_f[i]),
                    arrowprops=dict(facecolor='#FF5F1F', edgecolor='#EC5800', shrink=0, width=2, headwidth=8, headlength=10),
                    zorder=4)


        # plt.arrow(hist_x[i], hist_f[i], dx, dy, head_width=0.1, fc='darkorange',  linewidth=2, zorder=4)
        # plt.text(hist_x[i], hist_f[i], f'x_{i+1}', fontsize=12, ha='center', zorder=5)
    plt.scatter(hist_x, hist_f, c='k', s=50, zorder=5) # Adding a circle at each point

    plt.xlabel('x')
    plt.ylabel('f(x)')
    plt.legend()
    plt.show() 

#=======================================================================================================================



