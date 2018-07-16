/*
 * PCG Random Number Generation.
 *
 * Copyright 2014 Melissa O'Neill <oneill@pcg-random.org>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * For additional information about the PCG random number generation scheme,
 * including its license and other licensing options, visit
 *
 *       http://www.pcg-random.org
 */

import haxe.Timer;
import haxe.Int32;
import haxe.Int64;

class PCG32
{
    public var state : Int64;
    public var inc : Int64;
    public var MULTIPLIER : Int64 ;

    public function new()
    {
        this.state = Int64.make(0x853c49e6,0x748fea9b);
        this.inc = Int64.make(0xda3e39cb,0x94b95bdb);
        MULTIPLIER = Int64.make(0x5851F42D,0x4C957F2D);
        var rndSeed : Int = Std.int(Timer.stamp()*1000);
        seed( rndSeed );
    }

    public function seed(rnd:Int):Void
    {
        var initState:Int64 = (rnd << 31 | Int64.ofInt(rnd));
        var initSeq:Int64 = (rnd << 31 | Int64.ofInt(rnd) );

        state = 0;
        inc = (initSeq << 1) | 1;
        pcg32Random();
        state += initState;
        pcg32Random();
    }

    private function pcg32Random():Int 
    {
        var xorshifted : Int32 = (((state >>> 18) ^ state) >>> 27).low;
        var rot:Int32 =  (state >>> 59).low;
        state = state*MULTIPLIER + (inc|1);
        return (xorshifted >> rot) | (xorshifted << ((-rot) & 31));
    }

    public function random(n:Int):Int 
    {
        if (n <= 0) {
            throw "n must be positive";
        }
        var bits:Int = 0;
        var val:Int = 0;
        do {
            bits = pcg32Random() >>> 1;
            val = bits % n;
        } while ( (bits - val + (n-1) ) < 0);
        return val;
    }
}
