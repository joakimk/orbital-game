Not really a game, more of a unrealistic orbit-simulator made in Elm.

The initial version was made on my flight home from #socratesUK 2016.

## Screenshot

![](https://s3.amazonaws.com/f.cl.ly/items/182v0w1x0i090b1W3a1y/orbital-game.png?v=fa29a743)

## How to run

Get Elm 0.17, then:

    elm package install -y
    elm-reactor

And visit <http://localhost:8000/Main.elm>.

## TODO

If I get around to it I'd like to...

* [x] Get orbits to work when more planets have gravity
* [x] Orient the planets toward the sun at all times so that the textures match
* [ ] Improve orbital physics
* [ ] Add some kind of game-play element. The idea was some kind of game where you have to figure out orbital paths when shooting to hit an object.
* [ ] Rewrite rendering in WebGL to reduce CPU usage
* [ ] Add a sun

## Credits

Textures are from "planets16.zip", CC-BY-SA licence by Viktor.Hahn@web.de. Comes from http://opengameart.org/content/16-planet-sprites.

## Licence

Copyright (c) 2016 [Joakim Kolsjö](https://twitter.com/joakimk)

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
