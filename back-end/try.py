import pandas as pd
import numpy as np
import firebase_admin
import json
from werkzeug.serving import WSGIRequestHandler 
from flask import Flask, request, jsonify, url_for
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.metrics.pairwise import cosine_similarity
from firebase_admin import credentials, firestore, initialize_app

app = Flask(__name__)

cred = credentials.Certificate("key.json")
firebase_admin.initialize_app(cred)
db = firestore.client()
recom_title = db.collection(u'recommendations').document(u'first_recommendation').get()
recom_t = recom_title.get('title')
print(recom_t)

# Load the recipe dataset
data = pd.read_csv('data.csv')


# Function to recommend recipes based on a list of ingredients
@app.route('/ingredients')
def get_recommendations():
    # Create a bag of words for each recipe using the ingredients column
    vectorizer = CountVectorizer(tokenizer=lambda x: x.split(','), stop_words='english')
    ingredient_bow = vectorizer.fit_transform(data['ingredients'])

    # Compute cosine similarity between all pairs of recipes
    cosine_sim = cosine_similarity(ingredient_bow)

    # Example usage
    ingredients_list = ["kaddu (parangikai/ pumpkin)","r chilli powder","cumin powder (jeera)","coriand (dhania) leaves","salt"]

    # Create a bag of words for the input ingredients
    input_bow = vectorizer.transform([', '.join(ingredients_list)])
    print(input_bow)

    # Compute cosine similarity between the input ingredients and all recipes
    sim_scores = cosine_similarity(input_bow, ingredient_bow).flatten()
    print(sim_scores)

    # Sort recipes by similarity score and return top 5 recommendations
    sim_scores_in = sim_scores.argsort()[::-1]
    sim_scores_in = sim_scores_in[0:5]
    for index in sim_scores_in:
      print( f"The similarity value : {sim_scores[index]} ")
    

    g = pd.DataFrame(data)
    csv_data = g[['recipe_id','name', 'description', 'country', 'category', 'cook_time', 'ingredients',
            'instructions',
            'author', 'tags']].iloc[sim_scores_in]
    return_data = csv_data.to_json(orient="records")

    parse = json.loads(return_data)

    return json.dumps(parse)

if __name__ == "__main__":
    WSGIRequestHandler.protocol_version = "HTTP/1.1"
    app.run(debug=True)
    