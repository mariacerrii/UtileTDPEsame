-- ARCHI NON ORIENTATI
-- Evitare autoarchi e coppie inverse
WHERE t1.ID < t2.ID

-- ARCHI ORIENTATI
-- Evitare soltanto autoarchi
WHERE t1.ID != t2.ID

--29 giugno 2026, tipologia B
--Il grafo non orientato e non pesato.
--I nodi del grafo sono gli album che contengono almeno un brano
ARCHI
--Due album distinti sono collegati da un arco se contengono
--almeno un brano appartenente allo stesso genere musicale

SELECT DISTINCT
    t1.AlbumId AS v1,
    t2.AlbumId AS v2
FROM Track t1
JOIN Track t2 ON t1.GenreId = t2.GenreId
WHERE t1.AlbumId < t2.AlbumId

--29 giugno 2026, tipologia C
--grafo non orientato e pesato
-- I nodi rappresentano gli artisti presenti nel database che hanno pubblicato almeno un brano musicale.
ARCHI
--Due artisti distinti sono collegati da un arco se esiste almeno una playlist
--che contiene almeno un brano di entrambi gli artisti.
PESO DEGLI ARCHI
--Il peso di un arco è pari al numero di playlist distinte condivise dai due artisti.
SELECT
    a1.ArtistId AS v1,
    a2.ArtistId AS v2,
    COUNT(DISTINCT pt1.PlaylistId) AS peso
FROM Artist a1

JOIN Album al1 ON al1.ArtistId = a1.ArtistId
JOIN Track t1 ON t1.AlbumId = al1.AlbumId
JOIN PlaylistTrack pt1 ON pt1.TrackId = t1.TrackId
-- METTI CONFRONTO ENTRAMBI
JOIN PlaylistTrack pt2 ON pt2.PlaylistId = pt1.PlaylistId
--rifai lo stesso al contrario
JOIN Track t2 ON t2.TrackId = pt2.TrackId
JOIN Album al2 ON al2.AlbumId = t2.AlbumId
JOIN Artist a2 ON a2.ArtistId = al2.ArtistId
--condizione NON ORIENTATO
WHERE a1.ArtistId < a2.ArtistId

GROUP BY a1.ArtistId, a2.ArtistId

--GIUGNO TIPOLOGIA A
--grafo orientato e pesato
--I nodi rappresentano i clienti appartenenti a un Paese selezionato dall’utente che hanno effettuato almeno un acquisto.
ARCHI
DUE QUERY:
Prima query SQL → NODI + FATTURATO
--A ogni cliente è associato il suo fatturato totale, calcolato sommando gli importi delle sue fatture

Seconda query SQL → INFORMAZIONI PER GLI ARCHI
--Due clienti distinti sono collegati se hanno acquistato almeno un brano dello stesso artista.

DIREZIONE
L’arco è orientato:
* Dal cliente con fatturato maggiore a quello con fatturato minore.
* Se i fatturati sono uguali, vengono creati due archi, uno per ogni direzione.

PESO --> Il peso dell’arco è la somma dei fatturati totali dei due clienti

--Prima: ho preso nodi e l'ho aggiornata
SELECT c.CustomerId, c.FirstName, c.LastName, SUM(i.Total) AS Fatturato
FROM Customer c
JOIN Invoice i ON i.CustomerId = c.CustomerId
WHERE c.Country = %s
GROUP BY c.CustomerId, c.FirstName, c.LastName
ORDER BY c.CustomerId

ARCHI --> HO GESTITO LE COPPIE
SELECT DISTINCT
    c1.CustomerId AS v1,
    c2.CustomerId AS v2
FROM Customer c1
JOIN Invoice i1 ON i1.CustomerId = c1.CustomerId
JOIN InvoiceLine il1 ON il1.InvoiceId = i1.InvoiceId
JOIN Track t1 ON t1.TrackId = il1.TrackId
JOIN Album al1 ON al1.AlbumId = t1.AlbumId
JOIN Album al2 ON al2.ArtistId = al1.ArtistId
JOIN Track t2 ON t2.AlbumId = al2.AlbumId
JOIN InvoiceLine il2 ON il2.TrackId = t2.TrackId
JOIN Invoice i2 ON i2.InvoiceId = il2.InvoiceId
JOIN Customer c2 ON c2.CustomerId = i2.CustomerId
WHERE c1.CustomerId < c2.CustomerId



