# Using Conda environment to simulate Python 3.6
import discord
import wikipedia
import json
import numpy
import random
import nltk
nltk.download('punkt')  # Downloads the latest version of ntlk so that word_tokenizer works

from nltk.stem.lancaster import LancasterStemmer
import tflearn  # Requires TensorFlow 1.14 , Newer versions don't work
import tensorflow
import pickle

stemmer = LancasterStemmer()
prefix = '!'
bot = discord.Client()
token = "NzU1OTM4MTQ0MTUwNDg3MTEw.X2KkQg.ooD9SWPCr69BxFONA6XJD33-yXY"
trainNumber = 10000
errorThreshold = 0.7


# Loads the data from the json file, pre-processes it then loads it into a pickle file for later
def dataload():
    with open('intents.json') as file:
        data = json.load(file)
    words = []
    labels = []
    docs_x = []
    docs_y = []  # Each element in docs_x will relate to a tag in docs_y
    for intent in data["intents"]:
        for pattern in intent["patterns"]:
            wrds = nltk.word_tokenize(pattern)
            words.extend(wrds)
            docs_x.append(wrds)
            docs_y.append(intent["tag"])

        if intent["tag"] not in labels:
            labels.append(intent["tag"])
    # Stems words and sorts them in a set
    words = [stemmer.stem(w.lower()) for w in words if w != "?"]
    words = sorted(list(set(words)))
    labels = sorted(labels)

    # Convert data into bags of words eg: [1,0,0,0,1,0,0,1,1,1,0] | neural nets don't take words they take numbers
    # 1 = Word exists | 0 = Word doesn't exist
    training = []
    output = []
    out_empty = [0 for _ in range(len(labels))]

    for x, doc in enumerate(docs_x):
        bag = []
        wrds = [stemmer.stem(w) for w in doc]

        for w in words:
            if w in wrds:
                bag.append(1)
            else:
                bag.append(0)
        output_row = out_empty[:]
        output_row[labels.index(docs_y[x])] = 1

        training.append(bag)
        output.append(output_row)
    training = numpy.array(training)
    output = numpy.array(output)
    with open("data.pickle", "wb") as f2:
        pickle.dump((words, labels, training, output), f2)
    return data


# Neural net model
try:
    with open('data.pickle', "rb") as f:
        words, labels, training, output = pickle.load(f)
        with open('intents.json') as file:
            data = json.load(file)
except:
    data = dataload()
    with open('data.pickle', "rb") as f2:
        words, labels, training, output = pickle.load(f2)
# Start of Model
tensorflow.reset_default_graph()

net = tflearn.input_data(shape=[None, len(training[0])])
net = tflearn.fully_connected(net, 8)
net = tflearn.fully_connected(net, 8)
net = tflearn.fully_connected(net, len(output[0]), activation="softmax")
net = tflearn.regression(net)
# Feeding the model the neural net, fitting it and training it
model = tflearn.DNN(net)

try:
    model.load("model.tflearn")
except:
    model.fit(training, output, n_epoch=trainNumber, batch_size=8, show_metric=True)
    model.save("model.tflearn")


# Converts the input to a bag of words for the neural net
def bagInput(words, m):
    bag = [0 for _ in range(len(words))]
    message = nltk.word_tokenize(m)
    message = [stemmer.stem(word.lower()) for word in message]
    for sentence in message:
        for i, w in enumerate(words):
            if w == sentence:
                bag[i] = 1
    return numpy.array(bag)


# Function that returns the Wikipedia summery for the desired topic
def query(topic):
    topic = topic.replace("wikipedia", "")
    try:
        embed = discord.Embed(title=f"Wikipedia Summery for {topic}", description=wikipedia.summary(topic, sentences=5),
                              colour=0x55cdc)
    except:
        embed = discord.Embed(title=f"Wikipedia Summery for {topic}", description="Sorry, I couldn't find anything.",
                              colour=0xF85252)
    return embed


# Final check if the bot runs
@bot.event
async def on_ready():
    print("Bot ready and connected.")
    print(f'{bot.user} is connected to the following guilds:')
    for guild in bot.guilds:
        print(f'{guild.name} (id: {guild.id})')


# Bot waiting to join a chat
@bot.event
async def on_guild_join(guild):
    hello = f"Hello I am Spectre, a chatbot powered by AI. Please use {prefix} as a prefix to message me."
    await guild.send(hello)


@bot.event
async def on_member_join(member):
    await member.create_dm()
    await member.dm_channel.send(f'Hi {member.name}, my name is Spectre, a chatbot powered by AI. Please use {prefix} as a '
                                 f'prefix to message me. I can also provide you with Wikipedia summaries on anything '
                                 f'you want, just type "!wikipedia (topic)" to use the feature.')


# Bot waiting for a message from the chat
@bot.event
async def on_message(message):
    if message.content.lower() == "exit code 0":
        quit()
    # So the bot doesn't read its own messages
    if message.author == bot.user:
        return
    if prefix in message.content.lower():
        # Remove "!"
        content = message.content.lower()
        content = content.replace('!', '')
        # Wikipedia function
        if 'wikipedia' in content:
            await message.channel.send(embed=query(content))
            return
        results = model.predict([bagInput(words, content)])
        temp = str(results[0]).replace("[", "")
        temp = temp.replace("]", "")
        temp = temp.replace("\n", "")
        temp = temp.split(" ")
        temp = list(filter(None, temp))
        final = list(map(float, temp))
        index_results = final.index(max(final))
        tag = labels[index_results]
        # Threshold for probability (could be better)
        if final[index_results] > errorThreshold:
            for tg in data["intents"]:
                if tg["tag"] == tag:
                    msg = tg["responses"]
            # Sends message to client
            await message.channel.send(random.choice(msg))
        else:
            await message.channel.send("I don't understand. Try rephrasing or typing something different.")


bot.run(token)
