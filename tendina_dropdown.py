#1. DAO.py — Recuperare i valori della tendina
@staticmethod
def getAllGenres():
    conn = DBConnect.get_connection()
    cursor = conn.cursor(dictionary=True)

    query = """
        SELECT GenreId, Name
        FROM Genre
        ORDER BY Name
    """

    cursor.execute(query)
    result = []

    for row in cursor:
        result.append(row)

    cursor.close()
    conn.close()

    return result


#2. MODEL.py — Recuperare i valori dal DAO
def getAllGenres(self):
    return DAO.getAllGenres()

------
def buildGraph(self, genreId):
    self._graph.clear()
    # Costruzione nodi e archi
    # utilizzando genreId nel DAO

#3 CONTROLLER.py — Riempire la tendina
#Supponendo che nella View esista dd_genre:

def fillDDGenre(self):
    genres = self._model.getAllGenres()

    self._view.dd_genre.options.clear()

    for g in genres:
        self._view.dd_genre.options.append(
            ft.dropdown.Option(
                key=str(g["GenreId"]),
                text=g["Name"]
            )
        )
    self._view.update_page()

#4. CONTROLLER.py — handle_grafo() con tendina
def __init__(self, view, model):
    # the view, with the graphical elements of the UI
    self._view = view
    # the model, which implements the logic of the program and holds the data
    self._model = model

    # Preparo i Paesi per la tendina
    self._countries = self._model.getAllCountries()
def handle_grafo(self, e):

    # Leggo il valore selezionato
    genreId = self._view.dd_genre.value

    # Controllo che sia stato selezionato
    if genreId is None:
        self._view.txt_result.controls.clear()
        self._view.txt_result.controls.append(
            ft.Text("Seleziona un genere!")
        )
        self._view.update_page()
        return

    # Costruisco il grafo
    self._model.buildGraph(int(genreId))

    # Stampo nodi e archi
    self._view.txt_result.controls.clear()
    self._view.txt_result.controls.append(
        ft.Text(f"Numero nodi: {self._model.getNumNodes()}")
    )

    self._view.txt_result.controls.append(
        ft.Text(f"Numero archi: {self._model.getNumEdges()}")
    )

    self._view.update_page()
#4 VIEW
#DEVI MODIFICARE LA VIEW:
#HAI QUESTA:
self._ddCountry = ft.Dropdown(label="Country")
#INSERISCI QUESTA:
self._controller.fillDDCountry()
#QUESTA LA HAI GIA
self._btnCreaGrafo