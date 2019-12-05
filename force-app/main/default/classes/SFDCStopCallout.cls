public with sharing class SFDCStopCallout {
    // Method to hit SFDC Stop Blogs API and get the response
    public static HTTPResponse getBlogs() {
        // Creating an instance of HTTP class
        HTTP http = new HTTP();
        // Creating an instance of HTTPRequest class
        HTTPRequest request = new HTTPRequest();
        // Setting up the endpoint and method for the HTTP request
        request.setEndpoint('https://sfdcstop.herokuapp.com/blogs');
        request.setMethod('GET');
        // Hitting the API and getting the response
        HTTPResponse response = http.send(request);
        // Checking the status code in the response
        if(response.getStatusCode() == 200) {
            // Deserializing the JSON response using the wrapper class
            SFDCStopBlogsWrapper responseWrapper = SFDCStopBlogsWrapper.parse(response.getBody());
            // Displaying the author information
            System.debug('Author:- ' + responseWrapper.author);
            if((responseWrapper.blogs!=null) && (!responseWrapper.blogs.isEmpty())) {
                // Displaying the information of each blog one by one
                for(Integer i=0; i<responseWrapper.blogs.size(); i++) {
                    SFDCStopBlogsWrapper.Blogs blog = responseWrapper.blogs.get(i);
                    System.debug('Blog Id:- ' + blog.id);
                    System.debug('Blog Title:- ' + blog.title);
                    System.debug('Blog URL:- ' + blog.url);
                }
            }
        }
        return response;
    }
}