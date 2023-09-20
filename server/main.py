from flask import Flask, json, request, jsonify
import database.db as db

def create_app():

    app = Flask(__name__)
    app.database = db


    app.database.makeDB()

    @app.route('/ping', methods=['get'])
    def ping():
        return 'pong'

    @app.route('/store_score_data', methods=['post'])
    def store_score_data():
        score_list = request.json

        try:
            app.database.insert_piano_data(
                name=score_list['name'],
                song_name=score_list['song_name'],
                song_part_name=score_list['song_part_name'],
                music_score=score_list['music_score'],
                tech_score=score_list['tech_score'],
                sound_score=score_list['sound_score'],
                articulation=score_list['articulation']
            )
        except:
            return '500'

        return '200'

    @app.route('/get_score_data', methods=['get'])
    def get_score_data():
        name = request.args.get('name')
        result = app.database.get_piano_data(name=name)

        return jsonify(result)

    return app

create_app().run(port=50000, host='0.0.0.0')