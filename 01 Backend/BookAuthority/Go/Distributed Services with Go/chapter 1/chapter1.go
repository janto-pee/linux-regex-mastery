// For their internal web APIs, the company may take advantage of technologies like protobuf for features that JSON/HTTP doesn’t provide—like type
// checking and versioning—but their public one will still be JSON/HTTP for
// accessibility. This is the same architecture I’ve used at my current and previous companies. At Segment we had a JSON/HTTP-based architecture that
// for years handled billions of API calls a month before we changed our internal
// services to use protobuf/gRPC to improve efficiency. At Basecamp, all services
// were JSON/HTTP-based and (as far as I know) still are to this day
Set Up the Projec

Since we’re using Go 1.13+, we’ll take advantage of modules1
 so you don’t have to
put your code under your GOPATH. We’ll call our project proglog, so open
your terminal to wherever you like to put your code and run the following
commands to set up your module:
$ mkdir proglog
$ cd proglog
$ go mod init github.com/travisjeffery/proglog


Build a Commit Log Prototype

For now, all you need to
know about commit logs is that they’re a data structure for an append-only
sequence of records, ordered by time, and you can build a simple commit log
with a slice.
checkout server/log.go
To append a record to the log, you just append to the slice. Each time we read
a record given an index, we use that index to look up the record in the slice.


Build a JSON over HTTP Server

Now we’ll write our JSON/HTTP web server. A Go web server comprises one
function—a net/http HandlerFunc(ResponseWriter, *Request)—for each of your API’s
endpoints. Our API has two endpoints: Produce for writing to the log and
Consume for reading from the log. When building a JSON/HTTP Go server,
each handler consists of three steps:
1. Unmarshal the request’s JSON body into a struct.
2. Run that endpoint’s logic with the request to obtain a result.
3. Marshal and write that result to the response.

If your handlers become much more complicated than this, then you should
move the code out, move request and response handling into HTTP middleware, and move business logic further down the stack.
checkout server/http.go
NewHTTPServer(addr string) takes in an address for the server to run on and returns
an *http.Server. We create our server and use the popular gorilla/mux library
to write n

Next, we’ll define our server and the request and response structs by adding
this snippet below NewHTTPServer():
server/http.go continued
We now have a server referencing a log for the server to defer to in its handlers.

A consume request specifies which records the
caller of our API wants to read and the consume response to send back those
records to the caller. Not bad for just 28 lines of code, huh?

Next, we need to implement the server’s handlers. Add the following code
below your types from the previous code snippet

The produce handler implements the three steps we discussed before:
unmarshaling the request into a struct, using that struct to produce to the
log and getting the offset that the log stored the record under, and marshaling
and writing the result to the response. Our consume handler looks almost
identical. Add the following snippet below your produce handler:

The consume handler is like the produce handler but calls Read(offset uint64) to
get the record stored in the log. This handler contains more error checking
so we can provide an accurate status code to the client if the server can’t
handle the request, like if the client requested a record that doesn’t exist


Run Your Server
The last code you need to write is a main package with a main() function to
start your server
In the root directory of your project, create a cmd/server
directory tree, and in the server directory create a file named main.go with
this code:
// cmd/server/main.go
Our main() function just needs to create and start the server, passing in the
address to listen on (localhost:8080) and telling the server to listen for and handle
requests by calling ListenAndServe(). Wrapping our server with the *net/http.Server
in NewHTTPServer() saved us from writing a bunch of code here—and anywhere
else we’d create an HTTP server.
It’s time to test our slick new service

Test Your API
You now have a functioning JSON/HTTP commit log service you can run and
test by hitting the endpoints with curl. Run the following snippet to start the
server:
$ go run main.go

Open another tab in your terminal and run the following commands to add
some records to your log:
$ curl -X POST localhost:8080 -d \
'{"record": {"value": "TGV0J3MgR28gIzEK"}}'
$ curl -X POST localhost:8080 -d \
'{"record": {"value": "TGV0J3MgR28gIzIK"}}'
$ curl -X POST localhost:8080 -d \
'{"record": {"value": "TGV0J3MgR28gIzMK"}}'
Go’s encoding/json package encodes []byte as a base64-encoding string. The
record’s value is a []byte, so that’s why our requests have the base64 encoded
forms of Let’s Go #1–3. You can read the records back by running the following
commands and verifying that you get the associated records back from the
server:
$ curl -X GET localhost:8080 -d '{"offset": 0}'
$ curl -X GET localhost:8080 -d '{"offset": 1}'
$ curl -X GET localhost:8080 -d '{"offset": 2}'
Congratulations—you have built a simple JSON/HTTP service and confirmed
it works!
