import times, os, httpclient, json, sequtils
export httpclient.HttpClient

proc filetypes*(client: HttpClient, token: string, verbose: bool = false): seq =
  const url = "https://www.admiral-stats.com/api/v1/import/file_types"
  client.headers = newHttpHeaders({
    "User-Agent": "AdmiralStatsExporter-Nim-CLI",
    "Authorization": "Bearer " & token,
  })
  let response = client.request(url, HttpGet)
  if verbose: echo "file_types(" & response.status & "): " & response.body
  result = response.body.parseJson.getElems.map(proc (it: JsonNode): string = it.getStr)

