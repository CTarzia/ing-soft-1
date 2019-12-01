export default getLocalAsJson = (path) => {
    const port = 8005

    return fetch(`http://localhost:${port}/${path}`, {
        method: "GET",
        dataType: "JSON",
        headers: {
        "Access-Control-Request-Headers": "*"
        }
    })
}