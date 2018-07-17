# hxprng
At the moment implements only [PCG](http://www.pcg-random.org/) random number generator

## Usage
You should call method `random(n:Int)` . This will return a random integer between 0 included and n excluded.
```haxe
 var pg: PCG32 = new PCG32();
 var rnd : Int = pg.random(6) + 1; //add 1 to return a value between 1 and 6 (included)
 trace("Dice : " + rnd);
```

To get random number between range ( min - max) you can use `randomFromInterval(min:Int, max:Int)` , where min < max
```haxe
 var pg: PCG32 = new PCG32();
 var month : Int = pg.randomFromInterval(1,12); // return a value between 1 and 12 (included)
 trace("Month : " + month);
```
