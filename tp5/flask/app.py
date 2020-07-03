from flask import Flask
from flask import request
import json as j

app = Flask(__name__)

lista_alumnos = {"12345678" : "Juan Manuel de Rosas",
        	 "87654321" : "Manuel Belgrano",
             "39621464" : "San Martin"}

@app.route('/')
def root():
    return 'Hola, Nati!'

@app.route('/alumnos', methods=['GET', 'POST'])
def alumnos():
    if request.method == 'GET':
        json = j.dumps(lista_alumnos)
        return json
    else:
        ID = request.form['id']
        name = request.form['nombre']
        
        lista_alumnos[ID] = name
        return 'AGREGA2\n'

@app.route('/alumnos/<id_a>', methods=['GET', 'DELETE'])
def id(id_a):
    result = lista_alumnos.get(id_a, 0)
    if result == 0:
        return 'No existe el alumno'
    elif request.method == 'GET':
        return lista_alumnos[id_a]
    else: #Es un DELETE
    	lista_alumnos.pop(id_a)
    	return 'ELIMINA2\n'
    
