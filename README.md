JBModel-Swift
=============

My stab at a Swift implementation of JBModel. The premise is that you have a base model that will de/serialize properties in and out of Arrays/Dictionaries returned from a JSON string. This is very usefule for writing apps that use JSON apis.

Currently I work mostly with Rails as backend services and you can usually expect things returned from an api call to be in a certain structure. For instance, say you had a company model (on server) and an api call like `/api/companies/12`. The JSON response would probably look like so:

<pre>
{
 "name":"Doodle Corp",
 "president":
            {
             "name":"John Stobs",
             "age":58
            }
}
</pre>

When this response is returned to the iOS client, there's no need to fill in the whole object graph manually. In theory, the following should happen:

1. our network client/manager should hit the end point
2. client/manager receives successful response, transforms JSON to a Dictionary (or Array)
3. client/manager also knows that it is in the context of a 'Company' and so it creates the top level model for the graph
4. client/manager then passes Dictionary off to JBModel subclass (in this case, probably Customer) and JBModel populates the rest of the properties graph.

I've used the Objective-C version of this in a few production apps and they are very stable and have de/serialized millions of models over the years with little or no crashes.

Now, this is the Swift version. This is super preliminary and the only thing I have working is testing of various property values, Arrays, and Dictionaries being serialized into the proper places in a test User model.

Swift is also a moving target at this point and Apple has stated that there is not 'real' solution yet for class reflection/introspection like Objective-C has. There are a few things that help us out, but they could go away in the next beta.

That said, I don't think (or, I hope not) that Apple will bar this feature from working in Swift. People want it and maybe a more formal way will appear later. This is meant mostly for study now and I have a project I'm working on currently where I want to use this. So I'm making it.

I'll be updating this as I go along and will announce here if I have to call it quits for some reason. If not, then I plan on getting this into the App store this year in my current project (maybe a few others).

I'll be posting some follow up on my Swift blog - <a href="http://www.swiftpursuit.com">Swift Pursuit</a>. Pull requests are welcome, but I can't guarantee anything. 

_Fine print: I am building this for how I work on projects, so if it doesn't do what you want, please feel free to fork and do what you want with it. I'm taking a very opinionated approach to this and only building it for what I want._

**Contact:**

* here, on this repo
* Twitter: <a href="https://twitter.com/jasonbits">@jsonbits</a>
* Or see my <a href="http://www.swiftpursuit.com/about">Swift Pursuit blog about page</a> 

