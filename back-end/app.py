import pandas as pd
import numpy as np
import firebase_admin
import json
from werkzeug.serving import WSGIRequestHandler 
from flask import Flask, request, jsonify, url_for
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.metrics.pairwise import cosine_similarity
from firebase_admin import credentials, firestore, initialize_app

app = Flask(__name__)

#connect to Firebase
cred = credentials.Certificate("key.json")
firebase_admin.initialize_app(cred)
db = firestore.client()
recom_title = db.collection(u'recommendations').document(u'first_recommendation').get()
recom_t = recom_title.to_dict().get('ingredients')

#read dataset
df = pd.read_csv('data.csv')

#create bag word of combination name and category
df['bag'] = df['name'] + ' ' + df['category']
df['bag'] = df['bag'].fillna('')
df['bag'] = df['bag'].tolist()
# modeling
tfv = TfidfVectorizer(min_df=3, max_features=None, strip_accents='unicode', analyzer='word', token_pattern=r'\w{1,}',
                      ngram_range=(1, 3))
tfidf_matrix = tfv.fit_transform(df['bag'])
doc_vectors = tfidf_matrix.toarray()
# tfidf_matrix = tfv.fit_transform(df['bag'])
# cos_sim = cosine_similarity(tfidf_matrix, tfidf_matrix)
# indices = pd.Series(df.index, index=df['name']).drop_duplicates()


@app.route('/')
def index():
    return "Hello, Welcome to Cookbook Android-Based API Project"


@app.route('/title', methods = ['GET', 'POST'])
def updateTitle():
    global response

    if(request.method == 'POST'):
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))
        title = request_data['title']
        update_t = db.collection(u'recommendations').document(u'second_recommendation').update({"title" : title})
        response = f'Your Preference : {update_t}'
        print(response)
        return " "


# Get recommendations based on title input
@app.route("/recomendation")
def recommendations():
    try:
        get_updated = db.collection(u'recommendations').document(u'second_recommendation').get()
        title = get_updated.get('title')
        input_vector = tfv.transform([title]).toarray()

        cos_sim = cosine_similarity(input_vector,doc_vectors)[0]

        sim_scores_in = cos_sim.argsort()[::-1]
        sim_scores_in = sim_scores_in[0:5]
        for index in sim_scores_in:
            print(f"The similarity value : {cos_sim[index]} ")
    

        g = pd.DataFrame(df)
        csv_data = g[['recipe_id','name', 'description', 'country', 'category', 'cook_time', 'ingredients',
            'instructions',
            'author', 'tags']].iloc[sim_scores_in]
        return_data = csv_data.to_json(orient="records")

        parse = json.loads(return_data)

        return json.dumps(parse)
    except:
        return json.dumps([{"response" : "No recommendations"}])

@app.route("/newrecommendation")
def newrec():
    try:
        new_tfidf_matrix = tfv.fit_transform(df['bag'])
        cos_sim = cosine_similarity(new_tfidf_matrix, tfidf_matrix)
        indices = pd.Series(df.index, index=df['name']).drop_duplicates()
        get_updated = db.collection(u'recommendations').document(u'third_recommendation').get()
        title = get_updated.get('title')
        print(title)
        idx = indices[title]
        cos_sim_scores = list(enumerate(cos_sim[idx]))
        cos_sim_scores = sorted(cos_sim_scores, key=lambda x: x[1], reverse=True)
        cos_sim_scores = cos_sim_scores[1:6]
        print(cos_sim_scores)
        recom_indices = [i[0] for i in cos_sim_scores]
        g = pd.DataFrame(df)
        data = g[['recipe_id','name', 'description', 'country', 'category', 'cook_time', 'ingredients',
            'instructions',
            'author', 'tags']].iloc[recom_indices]
        return_data = data.to_json(orient="records")

        parse = json.loads(return_data)

        return json.dumps(parse)
    except:
        return json.dumps([{"response" : "No recommendations"}])


@app.route("/popular")
def popular_recommendations():
    data = pd.DataFrame(
        df[['recipe_id','name', 'vote_count', 'description', 'country', 'category', 'vegetarian_status', 'cook_time', 'ingredients',
            'instructions',
            'author', 'tags']])
    data.sort_values(['vote_count'], axis = 0, ascending=[False], inplace=True)
    data = data[0:4]
    return_data = data.to_json(orient="records")
    prse = json.loads(return_data)
    response = json.dumps(prse)
    # response = app.response_class(
    #     response=json.dumps(prse, indent=4),
    #     status=200,
    #     mimetype='application/json'
    # )
    return response

@app.route("/morepopular")
def more_popular_recommendations():
    data = pd.DataFrame(
        df[['recipe_id','name', 'vote_count', 'description', 'country', 'category', 'vegetarian_status', 'cook_time', 'ingredients',
            'instructions',
            'author', 'tags']])
    data.sort_values(['vote_count'], axis = 0, ascending=[False], inplace=True)
    data = data[0:19]
    return_data = data.to_json(orient="records")
    prse = json.loads(return_data)
    response = json.dumps(prse)
    # response = app.response_class(
    #     response=json.dumps(prse, indent=4),
    #     status=200,
    #     mimetype='application/json'
    # )
    return response

@app.route("/morerecomendation")
def more_recommendations():
    try:
        get_updated = db.collection(u'recommendations').document(u'second_recommendation').get()
        title = get_updated.get('title')
        input_vector = tfv.transform([title]).toarray()

        cos_sim = cosine_similarity(input_vector,doc_vectors)[0]

        sim_scores_in = cos_sim.argsort()[::-1]
        sim_scores_in = sim_scores_in[0:21]
        for index in sim_scores_in:
            print(f"The similarity value : {cos_sim[index]} ")
    

        g = pd.DataFrame(df)
        csv_data = g[['recipe_id','name', 'description', 'country', 'category', 'cook_time', 'ingredients',
            'instructions',
            'author', 'tags']].iloc[sim_scores_in]
        return_data = csv_data.to_json(orient="records")

        parse = json.loads(return_data)

        return json.dumps(parse)
    except:
        return json.dumps([{"response" : "No recommendations"}])


# Function to recommend recipes based on a list of ingredients
@app.route('/ingredients')
def get_recommendations():
    try:
        # Create a bag of words for each recipe using the ingredients column
        vectorizer = TfidfVectorizer(tokenizer=lambda x: x.split(','), stop_words='english')
        ingredient_bow = vectorizer.fit_transform(df['ingredients'])

        # Compute cosine similarity between all pairs of recipes
        cosine_sim = cosine_similarity(ingredient_bow)

        # Example usage
        # Get the document containing the array field
        doc_ing = db.collection(u'recommendations').document(u'first_recommendation').get()
        ingredients_list = doc_ing.to_dict().get('ingredients')
        print(ingredients_list)

        # Create a bag of words for the input ingredients
        input_bow = vectorizer.transform([', '.join(ingredients_list)])
        print(input_bow)

        # Compute cosine similarity between the input ingredients and all recipes
        sim_scores = cosine_similarity(input_bow, ingredient_bow).flatten()
        print(sim_scores)

        # Sort recipes by similarity score and return top 5 recommendations
        sim_scores_in = sim_scores.argsort()[::-1]
        sim_scores_in = sim_scores_in[0:21]
        for index in sim_scores_in:
            print(f"The similarity value : {sim_scores[index]} ")
    

        g = pd.DataFrame(df)
        csv_data = g[['recipe_id','name', 'description', 'country', 'category', 'cook_time', 'ingredients',
            'instructions',
            'author', 'tags']].iloc[sim_scores_in]
        return_data = csv_data.to_json(orient="records")

        parse = json.loads(return_data)

        return json.dumps(parse)
    except:
        return json.dumps([{"response" : "No recommendations"}])

if __name__ == "__main__":
    WSGIRequestHandler.protocol_version = "HTTP/1.1"
    app.run(debug=True)