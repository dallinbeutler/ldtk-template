// package core;

// @:structInit class Geodetic3D {
//     public var Longitude:Double;
//     public var Latitude:Double;
//     public var Height:Double;
//     public function new(lon,lat,height){
//         Latitude = lat;
//         Longitude = lon;
//         this.Height = height;
//     }
// }

// @:structInit class Geodetic2D {
//     public var Longitude:Double;
//     public var Latitude:Double;
//     public function new(lon,lat){
//         Latitude = lat;
//         Longitude = lon;
//     }
// }



// public static class Trig
// {
//     public final OneOverPi:Double= 1.0 / Math.PI;
//     public final PiOverTwo:Double= Math.PI * 0.5;
//     public final PiOverThree:Double= Math.PI / 3.0;
//     public final PiOverFour:Double= Math.PI / 4.0;
//     public final PiOverSix:Double= Math.PI / 6.0;
//     public final ThreePiOver2:Double= (3.0 * Math.PI) * 0.5;
//     public final TwoPi:Double= 2.0 * Math.PI;
//     public final OneOverTwoPi:Double= 1.0 / (2.0 * Math.PI);
//     public final RadiansPerDegree:Double= Math.PI / 180.0;

//     public static function ToRadians(degrees:Double):Double
//     {
//         return degrees * RadiansPerDegree;
//     }

//     public static function ToRadians( geodetic: Geodetic3D): Geodetic3D
//     {
//         return new Geodetic3D(ToRadians(geodetic.Longitude), ToRadians(geodetic.Latitude), geodetic.Height);
//     }

//     public static function ToRadians(geodetic:Geodetic2D):Geodetic2D
//     {
//         return new Geodetic2D(ToRadians(geodetic.Longitude), ToRadians(geodetic.Latitude));
//     }

//     public static function ToDegrees( radians:Double):double
//     {
//         return radians / RadiansPerDegree;
//     }

//     public static function ToDegrees( geodetic:Geodetic3D): Geodetic3D
//     {
//         return new Geodetic3D(ToDegrees(geodetic.Longitude), ToDegrees(geodetic.Latitude), geodetic.Height);
//     }

//     public static function ToDegrees( geodetic:Geodetic2D): Geodetic2D
//     {
//         return new Geodetic2D(ToDegrees(geodetic.Longitude), ToDegrees(geodetic.Latitude));
//     }

// }