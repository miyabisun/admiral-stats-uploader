import os, httpclient
export httpclient.HttpClient

proc upload*(client: HttpClient, token: string, file_type: string, body: string, time: string, verbose: bool = false): bool =
  let url = "https://www.admiral-stats.com/api/v1/import/" & file_type & "/" & time
  client.headers = newHttpHeaders({
    "Content-Type": "application/json",
    "User-Agent": "AdmiralStatsExporter-Nim-CLI",
    "Authorization": "Bearer " & token,
  })
  let response = client.request(url, HttpPost, body)
  if verbose: echo "[post]" & file_type & "(" & response.status & "): " & response.body
  result = response.status == "201 Created" or response.status == "200 OK"

