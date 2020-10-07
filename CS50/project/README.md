# CS50 Final Project

## Design
The AI utilises the tfLearn library to create a neural net. The neural net is then fed, from a JSON file, with potential patterns to look for in its inputs and is trained on this data. When the AI recieves a message with a specific prefix ,"!", it will feed the input into the neural net and make a prediction on how likely the input is to be in a category (i.e. Hello, goodbye, application, thanks, etc... category). The bot will rendomly choose a response from the response dataset and send it to the Discord API to be sent on the chat.

### Wikipedia
The bot also uses the wikipedia API to give Wikipedia summaries to the person who starts their message with "!wikipedia" then types the desired topic.


Thanks to my friend Josh for helping me with the dataset for inputs and responses for the AI as well as the profile picture.

Credit to [Tech With Tim](https://www.youtube.com/watch?v=ON5pGUJDNow&list=PLzMcBGfZo4-ndH9FoC4YWHGXG5RZekt-Q&index=2) for teaching me how to code the AI aswell as understanding the asociated libraries.
