# JSONPath.sh

yo, so it's a JSONPath implementation written in Bash - and it probably only works in Bash.

[![travis](https://secure.travis-ci.org/mclarkson/JSONPath.sh.png?branch=master)](https://travis-ci.org/mclarkson/JSONPath.sh)

## Invocation

    JSONPath.sh [-b] [-i] [-j] [-h] [-p] [-u] [-f FILE] [pattern]

pattern
> the JSONPath query. Defaults to '$.\*' if not supplied.

-b
> Brief output. Only show the values, not the path and key.

-f FILE
> Read a FILE instead of reading from standard input.

-i
> Case insensitive searching.

-j
> Output in JSON format, instead of JSON.sh format.

-u
> Strip unnecessary leading path elements.

-p
> Pass JSON.sh formatted data through to the JSON parser only. Useful after
> JSON.sh data has been manipulated.

-h
> Show help text.

## Requirements

JSONPath.sh is a Bash script that uses the standard GNU tools: *bash*, *cat*, *sed*, *awk*, *grep*, and *seq*.

## Installation

Install with pip:

* `sudo pip install git+https://github.com/mclarkson/JSONPath.sh#egg=JSONPath.sh`

Install with npm:

* `sudo npm install -g jsonpath.sh`

Or copy the `JSONPath.sh` script to your PATH, for example:

``` bash
curl -O https://raw.githubusercontent.com/mclarkson/JSONPath.sh/master/JSONPath.sh
chmod +x JSONPath.sh
mv JSONPath.sh ~/bin
```

## Examples

``` bash
$ ./JSONPath.sh < package.json
["name"]        "JSONPath.sh"
["version"]     "0.0.0"
["description"] "JSONPath implementation written in Bash"
["homepage"]    "http://github.com/mclarkson/JSONPath.sh"
["repository","type"]   "git"
["repository","url"]    "https://github.com/mclarkson/JSONPath.sh.git"
["bin","JSONPath.sh"]   "./JSONPath.sh"
["author"]      "Mark Clarkson <mark.clarkson@smorg.co.uk>"
["scripts","test"]      "./all-tests.sh"
```

more complex examples:

*NPMJS.ORG EXAMPLES*

``` bash
# Number of downloads yesterday
curl -s https://api.npmjs.org/downloads/point/last-day/jsonpath.sh | \
    JSONPath.sh '$.downloads' -b

# Show all versions
curl registry.npmjs.org/express | ./JSONPath.sh '$.versions.*.version'

# Show version 2.2.0
./JSONPath.sh \
    -f test/valid/npmjs.org.json \
    '$.versions.["2.2.0"]'

# Find versions 2.2.x (using a regular expression)
# and show version and contributors
./JSONPath.sh \
    -f test/valid/npmjs.org.json \
    '$..["2.2.*"].[version,contributors]'
```
*JSONPATH.ORG EXAMPLES*

``` bash
# The default query
./JSONPath.sh \
    -f test/valid/jsonpath.com.json \
    '$.phoneNumbers[:1].type'

# The same, but using a filter (script) expression
# (This takes 2 passes through the data)
./JSONPath.sh \
    -f test/valid/jsonpath.com.json \
    '$.phoneNumbers[?(@.type=iPhone)]'
```

*KUBERNETES EXAMPLES*

``` bash
# Show the NodePort of a service named bob
# from a list of all services
kubectl get svc -o json | JSONPath.sh \
    '$..items[?(@.metadata.name==bob)].spec.ports[0].nodePort' -b

# Or, more simply, show the NodePort of the service
kubectl get svc bob -o json | JSONPath.sh '$..nodePort' -b

# Get the port of the kubernetes-dashboard and output as json:
kubectl get svc --all-namespaces -o json | JSONPath.sh -j -u \
    '$.items[?(@.spec.selector.app=".*dashboard")]..ports[*].nodePort'
```

*DOCKER EXAMPLES*

``` bash
# Show Everything
./JSONPath.sh -f test/valid/docker_stopped.json '$.*'

# Look for an ip address (using case insensitive searching to start)
./JSONPath.sh \
    -f test/valid/docker_running.json \
    /valid/docker_running.json -i '$..".*ip.*"'

# Now get the IP address exactly
./JSONPath.sh \
    -f test/valid/docker_running.json \
    '$.*.NetworkSettings.IPAddress' -b

# Show all Mounts
./JSONPath.sh \
    -f test/valid/docker_stopped.json \
    '$.[*].Mounts'

# Show sources and destinations for all mounts
./JSONPath.sh \
    -f test/valid/docker_stopped.json \
    '$.[*].Mounts[*].[Source,Destination]'

# Use brief (-b) output to store mounts in an array for use in a loop
readarray -t MNTS \
  < <(./JSONPath.sh -b -f test/valid/docker_stopped.json '$.*.Mounts[*].[Source,Destination]')

# the loop:
for idx in `seq 0 $((${#MNTS[*]}/2-1))`; do
    echo "'${MNTS[idx*2]}' is mounted on the host at '${MNTS[idx*2+1]}'"
done
```

*GOESSNER.NET (EXPANDED) EXAMPLES*

``` bash
# dot-notation (my latest favourite book)
./JSONPath.sh \
    -f test/valid/goessner.net.expanded.json \
    '$.store.book[16].title'

# dot-notation with a node set
./JSONPath.sh \
    -f test/valid/goessner.net.expanded.json \
    '$.store.book[4,6,16,22].title'

# bracket-notation ('$[' needs escaping at the
# command line, so bash doesn't think it's an
# arithmetic expression)
./JSONPath.sh \
    -f test/valid/goessner.net.expanded.json \
    "\$['store']['book'][16]['title']"

# bracket-notation with an array slice and a set
./JSONPath.sh \
    -f test/valid/goessner.net.expanded.json \
    "\$['store']['book'][14:25:2]['title','reviews']"

# Mixed bracket- and dot- notation
./JSONPath.sh \
    -f test/valid/goessner.net.expanded.json \
    "\$['store'].book[16].title"

# Show all titles
./JSONPath.sh \
    -f test/valid/goessner.net.expanded.json \
    '$..book[*].title'

# All books with 'Book 1' somewhere in the title
./JSONPath.sh \
    -f test/valid/goessner.net.expanded.json \
    -i '$..book[?(@.title==".*Book 1.*")].title'

# All books with a price less than or equal to 4.20
# Show both the title and the price and output in
# JSON format but without redundant path elements.
./JSONPath.sh -j -u \
    -f test/valid/goessner.net.expanded.json \
    '$.store.book[?(@.price<4.20)].[title,price]'

# The following does not work yet (TODO) 
./JSONPath.sh \
    -f test/valid/goessner.net.expanded.json \
    '$.store.book[(@.length-1)].title'
```

## JSONPath patterns and extensions

### Supported JSONPath options

| JSONPath               | Supported | Comment                                                 |
| -----------------------|-----------|---------------------------------------------------------|
| $                      |     Y     | the root object/element (optional)                      |
| @                      |     Y     | the current object/element                              |
| . or []                |     Y     | child operator.                                         |
| ..                     |     Y     | recusive descent.                                       |
| *                      |     Y     | wildcard. All objects/elements regardless their names.  |
| []                     |     Y     | subscript operator.                                     |
| [,]                    |     Y     | node sets.                                              |
| ```[start:end:step]``` |     Y     | array slice operator.                                   |
| ?()                    |     Y     | applies a filter (script) expressions                   |
| ()                     |     Y     | script expression, using the underlying script engine.  |

### Searching for things

"regex"

Use a regular expression inside the JSONPath pattern.<br>
Combine with '-i' for case insensitive search.<br>
Combine with '-w' to match whole words only.

Examples:

Find every node key starting with 'ip':

``` bash
# These are all equivalent
./JSONPath.sh -f test/valid/docker_running.json -i "$..['ip.*']"
./JSONPath.sh -f test/valid/docker_running.json -i '$..["ip.*"]'
./JSONPath.sh -f test/valid/docker_running.json -i '$.."ip.*"'
./JSONPath.sh -f test/valid/docker_running.json -i "$..'ip.*'"
```

Restrict the previous search to the bridge object.

``` bash
./JSONPath.sh -f test/valid/docker_running.json -i "$..bridge.'ip.*'"
```

Show all book titles by authors starting with 'Doug'.

``` bash
# Show the title
./JSONPath.sh -f test/valid/goessner.net.expanded.json -i \
    "$..book[?(@.author==Doug)].title"

# Show the author, title and rating (can be with or without double quotes)
./JSONPath.sh -f test/valid/goessner.net.expanded.json -i \
    '$..book[?(@.author="Doug")].["author","title",rating]'
```

### Modification

A common task is to modify JSON data on-the-fly. Unix style 'one-liners' can be
created to easily and logically modify JSON data.

The key to data modification (that is: add, modify or deletion of data) is to
modify the *JSON.sh* formatted data, then use the passthrough, '-p', option to
output again as JSON. Sequence is:

1. Read JSON data and output as *JSON.sh* data.
2. Modify *JSON.sh* data using standard Unix tools.
3. Pipe modified *JSON.sh* data to JSONPath.sh with passthrough option producing
   JSON data again.

For example: The following 'one-liner' will read a kubernetes deployment
configuration (using 'kubectl get ...'), output it in *JSON.sh* format (using
'JSONPath.sh'), change the number of replicas from the existing value to 5
(using *sed*), output again in JSON (using 'JSONPath.sh -p'), then replace the
original deployment with the newly changed one (using 'kubectl replace ...').

```
kubectl get deployment sample-deployment -o json | \
JSONPath.sh | \
sed 's/\["spec","replicas"\].*/["spec","replicas"]\t5/' | \
JSONPath.sh -p | \
kubectl replace deployment sample-deployment -f -
```

This allows you to reuse your Unix skills rather than learn new terse syntax
or Domain Specific Language.

### Re-injection

This tool, JSONPath.sh, is really handy for handing json formatted
data to other tools, and using pass-through mode (-p) comes in quite
handy for creating complex queries and outputting in json.

**Re-injection** allows the user to overcome the limitation
of a single filter expression per invocation. To do this the first
query, or set of queries, should output in JSON format using the
'-j' option.

**Usage Example**

Show all books with a price greater than 4 that also have a 5 star
rating (note that the first process in the pipeline outputs in json):

```
./JSONPath.sh -j -f test/valid/goessner.net.expanded.json \
    '$..book[?(@.price>4)]' | ./JSONPath.sh \
    '$..book[?(@.rating==5)].title'
```

**Pass-through mode** reads the standard output JSONPath.sh (or JSON.sh)
produces and outputs JSON. This gives the user an opportunity to filter
or modify the results:

**Filtering Usage Example**

Show all authors, without showing duplicates and output in JSON format.

All authors with duplicates:

```
$ ./JSONPath.sh -f test/valid/goessner.net.expanded.json '$..author' 
... omitted ...
["store","book",9,"author"]     "James S. A. Corey"
["store","book",10,"author"]    "James S. A. Corey"
["store","book",11,"author"]    "James S. A. Corey"
... 25 lines of output ...
```

Use standard unix tools to remove duplicates:

```
$ ./JSONPath.sh -f test/valid/goessner.net.expanded.json '$..author' \
    | sort -k2 | uniq -f 1 
... 11 lines of output ...
```

And pipe (re-inject - 'cos it sounds cool) the output into JSONPath.sh:

```
$ ./JSONPath.sh -f test/valid/goessner.net.expanded.json '$..author' \
    | sort -k2 | uniq -f 1 \
    | ./JSONPath.sh -p
{
    "store":
    {
        "book":
        [
            {
                "author":"Douglas E. Richards"
            }
            ,{
                "author":"Evelyn Waugh"
            }
... JSON output with unique data ...
```

Use the '-u' option to flatten the output:

```
$ ./JSONPath.sh -f test/valid/goessner.net.expanded.json \
    '$..author' \
    | sort -k2 | uniq -f 1 \
    | ./JSONPath.sh -p -u
... JSON flattened output ...
{
    "book":
    [
        {
            "author":"Douglas E. Richards" 
        },
        {
            "author":"Evelyn Waugh"
        },
```

**Filter and Merge Usage Example**

Different parts of JSON input, or entirely different JSON input, can be merged
together with Unix 'sort' and output in json format.

This is a complex kubernetes example that uses JSONPath.sh and standard Unix
tools to output just the command, pod mounts, and container mounts (output from
different parts of the tree) for the first matched kube-proxy pod.

```
# Get details of all pods
kubectl get -n kube-system pods -o json >/tmp/kpod

# Get the index of the first pod with name starting 'kube-proxy'
idx=`JSONPath.sh -f /tmp/kpod '$.items[?(@.metadata.name=="kube-proxy.*")].apiVersion' \
     | head -n1 | grep -o ',[0-9]\+,' | tr -d ,`

# Get three subtrees using the index and merge them using sort
# and then output in json format
( JSONPath.sh -f /tmp/kpod '$.items['$idx'].spec.volumes'; \
  JSONPath.sh -f /tmp/kpod '$.items['$idx']..volumeMounts'; \
  JSONPath.sh -f /tmp/kpod '$.items['$idx']..containers[*].command'
) | sort | JSONPath.sh -p -u
```

, which produces:

```
{
    "containers":
    [
        {
            "command":
            [
                "/usr/local/bin/kube-proxy",
                "--kubeconfig=/var/lib/kube-proxy/kubeconfig.conf"
            ],
            "volumeMounts":
            [
                {
                    "mountPath":"/var/lib/kube-proxy",
                    "name":"kube-proxy"
                },
                {
                    "mountPath":"/var/run/secrets/kubernetes.io/serviceaccount",
                    "name":"kube-proxy-token-m9b6j",
                    "readOnly":true
                }
            ]
        }
    ],
    "volumes":
    [
        {
            "configMap":
            {
                "defaultMode":420,
                "name":"kube-proxy"
            },
            "name":"kube-proxy"
        },
        {
            "name":"kube-proxy-token-m9b6j",
            "secret":
            {
                "defaultMode":420,
                "secretName":"kube-proxy-token-m9b6j"
            }
        }
    ]
}
```

## Cool Links

* [dominictarr/JSON.sh](https://github.com/dominictarr/JSON.sh) The original, the best, JSON.sh.

## Performance

* Performance is acceptable for small data sizes
* Worse when using:
    * large data files (hundreds of kilobytes).
    * filter (script) expressions (An extra pass is required).
    * Indexes greater than 9.
    * Indexes with steps even with indexes less than 10.
* Better with:
    * Small data files (A few kilobytes).
    * Indexes less than 10 (then matching is done by regex, unless a step is used).
    * No filter (script) expressions (so no extra pass through the data).

## Limitations (todo)

* Only one filter expression, '?(@', per query.
  Use re-injection, detailed above, to overcome this limitation.

## License

This software is available under the following licenses:

  * MIT
  * Apache 2

