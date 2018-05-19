import times, os, httpclient, json, sequtils

proc filetypes* (token: string): seq =
  const url = "https://www.admiral-stats.com/api/v1/import/file_types"
  let client = newHttpClient()
  client.headers = newHttpHeaders({
    "User-Agent": "AdmiralStatsExporter-Nim-CLI",
    "Authorization": "Bearer " & token,
  })
  let response = client.request(url, HttpGet)
  result = response.body.parseJson.getElems.map(proc (it: JsonNode): string = it.getStr)

