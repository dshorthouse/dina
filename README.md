# DINA Ruby Gem

The [DINA Consortium][1] develops an open-source web-based information management system for natural history data that consists of several connected software components. At the core of the system is support for assembling, managing and sharing data associated with natural history collections and their curation ("collection management"). Target collections include zoological, botanical, geological and paleontological collections, living collections, biodiversity inventories, observation records, and molecular data.

This Ruby 3.1 gem abstracts the Keycloak configuration and JSON:API models for the DINA collection management system. It depends on the [json_api_client][5] where more documentation is available on how to create, update, query, and delete objects.

### Disclaimer

The DINA APIs for each of its components are under rapid development and so too is this gem. The intent of the latter is to be as closely aligned with the most recent versions of the former. As such, this gem makes use of the DINA APIs via their single, frontend gateway.

[![Gem Version][8]][9]
[![Continuous Integration Status][6]][7]

### Requirements & Dependencies

- ruby >= 3.1
- bundled dependencies: [json_api_client][5] (\~> 1.20), [keycloak][10] (\~> 3.2.1),

### Install

```bash
$ gem install dina
```
### Configuration

All variables are **required** and most can be obtained from a DINA system administrator.
- `authorization_url`, `realm`, `client_id`, `user`, and `password`: used in the Keycloak authentication handshake
- `endpoint_url`: the single DINA gateway to JSON:API models
- `token_store_file`: your local file that caches authentication token responses, which are thereafter automatically reused and updated as needed

```ruby
require 'dina'
settings = {
   authorization_url: "http://localhost/auth",
   endpoint_url: "http://localhost/api",
   realm: "dina",
   client_id: "dina",
   user: "username",
   password: "password",
   token_store_file: "config/token.json"
 }
Dina.config = settings
```

#### Instantiate and Save a `Person`

```ruby
person = Dina::Person.new
person.givenNames = "Peter"
person.familyNames = "Pipetter"
person.email = "email@email.com"
person.save
=> true
```

Alternatively, use the `create` method to save a `Person` without having to instantiate it first:

```ruby
data = {
  givenNames: "Peter",
  familyNames: "pipetter",
  email: "email@email.com"
}
person = Dina::Person.create(data)
```

A new instance like `person` above sets and uses a default UUIDv4, which can be accessed as `person.id`.

#### Add an Identifier to a `person` Instance

```ruby
identifier = Dina::Identifier.new
identifier.namespace = "WIKIDATA"
identifier.value = "http://www.wikidata.org/entity/Q163373"
identifier.save
=> true

person.identifiers = [ identifier ]
person.save
=> true
```

Instance objects (like `identifier` above) must be saved before they can be attached to related objects (like `person` above).

#### Query for a `Person` by Email Address

```ruby
person = Dina::Person.find_by_email("email@email.com").first
person.attributes
=>
{"type"=>"person",                                                  
"id"=>"bf42616e-846c-4dbd-8372-bef44cdfa3e8",                      
"displayName"=>"Pipetter, Peter",                                  
"email"=>"email@email.com",                                        
"createdBy"=>"username",                                             
"createdOn"=>2022-11-25 17:23:09.262958 UTC,                       
"givenNames"=>"Peter",                                             
"familyNames"=>"Pipetter",                          
"aliases"=>nil,                                     
"webpage"=>nil,                                     
"remarks"=>nil,                                     
"identifiers"=>[]}
```

Unlike typical ActiveRecord methods, *find* or *find_by_\** methods return an array and so you must additionally use `.first` or `[0]`.

#### Delete a `Person`

```ruby
person = Dina::Person.find("bf42616e-846c-4dbd-8372-bef44cdfa3e8").first
person.destroy
=> true
```

#### Add an instance of a `collection method` to that of a `collecting event`

```ruby
# Find a collection method or create one as you would a person or identifier above
collection_method = Dina::CollectionMethod.find("bf42616e-846c-4dbd-8372-bef44cdfa3e9").first

collecting_event = Dina::CollectingEvent.new
collecting_event.group = "CNC"
collecting_event.collection_method = collection_method
collecting_event.save
=> true
```

#### Upload an Image `File` and its `ObjectStore` Metadata

```ruby
file = Dina::File.new
file.group = "DAOM"
file.filePath = "/my-directory/my-file.jpg"
file.fileName = "what-i-want-it-called.jpg" # the Original Filename in the DINA UI
file.dcFormat = "image/jpeg"
file.save # also injects attributes from the server response like dateTimeDigitized below
=> true

metadata = Dina::ObjectStore.new
metadata.group = "DAOM"
metadata.dcType = "IMAGE"
metadata.dcFormat = "image/jpeg"
metadata.fileExtension = ".jpg"
metadata.fileIdentifier = file.id
date_time = Time.find_zone("America/New_York")
                .parse(file.dateTimeDigitized)
                .rfc3339.to_s
metadata.acDigitizationDate = date_time
metadata.save
=> true
```

#### Find an Image Using a Managed Attribute

```ruby
payload = {
  query: {
    bool: {
      must: [
        { term: { "data.attributes.managedAttributes.original_directory_name.keyword":"dc1.2021-08-19_15-42-15_e49ba1" } },
        { term: { "data.attributes.group":"dao" } }
      ]
    }
  },
  size: 1
}
hits = Dina::Search.execute(index: "object_store", payload: payload)
=> [#<Dina::Search:@attributes={"type"=>"metadata", "id"=>"f5aeec1e-63f5-4c67-8ca6-e48b4415e299", "created_by"=>"s-dao", ... ]
```

### Schema

To list available JSON:API Classes:

```ruby
Dina.classes
```

To list available properties for a Class:

```ruby
Dina::MaterialSample.properties
```

To list relationships and their cardinality for a Class:

```ruby
Dina::MaterialSample.associations
```

### Connection Errors

In the event there are SSL certificate verification issues, you can skip verification:

```ruby
Dina::BaseModel.connection_options[:ssl] = { verify: false }
```

The ***best*** approach is to incorporate SSL certificates in one's operating system or environment if the host uses self-signed certificates that cannot be verified.

### Advanced

Flush the token from memory and save an empty token file

```ruby
Dina.flush
```

### Support

Bug reports can be filed at [https://github.com/dshorthouse/dina/issues][3].

### Copyright
Copyright © 2023 Government of Canada

Authors: [David P. Shorthouse][4], [Julia Douglas Freitas][11]

### License

`dina` is released under the [MIT license][2].

[1]: https://dina-project.net/
[2]: http://www.opensource.org/licenses/MIT
[3]: https://github.com/dshorthouse/dina/issues
[4]: https://github.com/dshorthouse
[5]: https://github.com/JsonApiClient/json_api_client
[6]: https://github.com/dshorthouse/dina/actions/workflows/ruby.yml/badge.svg
[7]: https://github.com/dshorthouse/dina/actions
[8]: https://badgen.net/rubygems/v/dina/latest?cache=300
[9]: https://rubygems.org/gems/dina
[10]: https://github.com/imagov/keycloak
[11]: https://github.com/juliadouglasf
