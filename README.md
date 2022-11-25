DINA Ruby Gem
=============

The [DINA Consortium][1] develops an open-source web-based information management system for natural history data that consists of several connected software components. At the core of the system is support for assembling, managing and sharing data associated with natural history collections and their curation ("collection management"). Target collections include zoological, botanical, geological and paleontological collections, living collections, biodiversity inventories, observation records, and molecular data.

This Ruby 3.1 gem abstracts the Keycloak configuration and JSON:API models for the DINA collection management system. It depends on the [json_api_client][5] where more documentation is available on how to create, update, query, and delete objects.

[![Continuous Integration Status][6]][7]

Usage
-----

Set-up:

```
  Dina::Authentication.config(
    {
      authorization_url: "http://localhost/auth",
      endpoint_url: "http://localhost/api/",
      server_name: "server",
      realm: "dina",
      client_id: "dina",
      user: "username",
      password: "password",
      token_store_file: "config/token.json"
    }
  )
```

Create and save a Person object:

```
  person = Dina::Person.new
  person.givenNames = "Peter"
  person.familyNames = "Pipetter"
  person.save
```


License
-------

`dina` is released under the [MIT license][2].

Support
-------

Bug reports can be filed at [https://github.com/dshorthouse/dina/issues][3].

Copyright
---------
2022 Government of Canada
Authors: [David P. Shorthouse][4]

[1]: https://dina-project.net/
[2]: http://www.opensource.org/licenses/MIT
[3]: https://github.com/dshorthouse/dina/issues
[4]: https://github.com/dshorthouse
[5]: https://github.com/JsonApiClient/json_api_client
[6]: https://github.com/dshorthouse/dina/actions/workflows/ruby.yml/badge.svg
[7]: https://github.com/dshorthouse/dina/actions
