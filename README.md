# Medlineplus Ruby

:gem: A Ruby API wrapper library, and Rails 5 demo application, for retrieving information from the National Library of
Medicine's ["Medlineplus Connect" API](https://medlineplus.gov/connect/overview.html).  

:eyeglasses: You can view a live demo of this application [on Heroku](https://toddsmedlinedemo.herokuapp.com/). Free Heroku dynos take a few moments to wake from sleep.  

:hospital: Currently there is one feature: fetching consumer facing information associated with
[ICD-10](https://en.wikipedia.org/wiki/ICD-10) codes.

----

Specs
-----

* **Ruby** >= 2.4.1
* **Rails** >= 5.1.0
* **RSpec** >= 3.6
* Hosted on Heroku's free tier.

:memo: _Note:_ This project focuses entirely on the back end, and not the presentation layer. As such, **jQuery**, **SASS**,
and **Bootstrap** are used together to simplify front end concerns. As the latest *Bootstrap 4 alpha* breaks version
*alpha-4*, its unlikely this application will update to follow subsequent releases of Bootstrap 4. You can check out  
some of my front end work here.

:gem: **Rubygem:** I am extracting the contents of [lib/](https://github.com/stratigos/medline_plus_connect_demo/tree/master/lib)
to a rubygem once development is finished within the scope of this test application. Currently it represents an API
client that simplifies making requests to the NLM API. The NLM API is far removed from modern web standards, and this
gem allows for a more seamless integration with Ruby medical applications.  

:traffic_light: **Tests:** BDD is practiced when it is feasible, and I aim to have 100% spec coverage.
* Run `./bin/rails spec` for the whole suite.
* Run `./bin/rails spec:presenters` for only running specs on PORO/Non-Rails classes. `presenters` can be replaced with
`services`, etc.  

:necktie: **Presenters:** While there are some great gems out there for Rails presenters, I like to keep things as simple until
there is a reasonable demand for robustness. I use PORO classes for [Presenter objects](https://github.com/stratigos/medline_plus_connect_demo/tree/master/app/presenters).  

:factory: **Services:** To keep models focused, I chose `aldous` for [Service objects](https://github.com/stratigos/medline_plus_connect_demo/tree/master/app/services). This pattern also keeps
domain responsibilities modularized and composable, and components are easier to test. The `aldous` gem has a very
simple and light abstraction for Service objects and encourages a reliable and standardized pattern for message passing.
It also encourages a consistent methodology for exception handling. I would not object to using PORO classes for an
application Services layer either.

:floppy_disk: **Persistence:** I write a lot of applications which interface with an RDBMS, and sometimes even dream in SQL. This application has no real need for a data layer, and as such does not demo my experience with MySQL and PostgreSQL. My
DBA chops can be revealed here, *{ in a TBD [Phoenix](http://www.phoenixframework.org/) application }*.

----

:wave: You can also check out [my other repositories](https://github.com/stratigos), and my ever so humble
[website](http://techarchist.com/). Thanks!

----

License
-------

MIT, see [LICENSE](https://github.com/stratigos/medline_plus_connect_demo/blob/master/LICENSE) file.
