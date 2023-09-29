import kotlin.math.*
import kotlin.random.Random

interface Transport{
    var priceToKM: Int
    var speed: Int
    var citySize: Int
    var Weather: Boolean
    var Accident: Double
    fun time(c1: City, c2: City): Double{
        return c1.dist(c2).toDouble()/speed
    }
    fun price(c1: City, c2: City):Double{
        return c1.dist(c2).toDouble()*priceToKM/100
    }
}
class Car():Transport{
    override var priceToKM = 500
    override var speed = 60
    override var citySize = 1 or 2 or 3
    override var Weather = true or false
    override var Accident = 0.1
}
class Train():Transport{
    override var priceToKM = 3000
    override var speed = 150
    override var citySize = 2 or 3
    override var Weather = true or false
    override var Accident = 0.01
}
class Plane():Transport{
    override var priceToKM = 7000
    override var speed = 600
    override var citySize = 3
    override var Weather = true
    override var Accident = 0.001
}
class City(val size: Int){
    var weather: Boolean = true
    fun dist(city: City):Int{
        return Random.nextInt(50,10000)
    }
}
class Client(var c1: City, var c2: City){
    var p: Int = 0
    var t: Int = 0
    constructor(c1: City, c2: City,
                _p: Int, _t: Int):this(c1,c2){
                    p = _p
                    t = _t
                }

}
class Agency(){
    var car = Car()
    var train = Train()
    var plane = Plane()
    fun transport(c: Client):Int{
        if(c.c1.weather == false || c.c2.weather == false){
            if(min(c.c1.size, c.c2.size)==3){
                return min(c.c1.size, c.c2.size)-1
            }
        }
        return min(c.c1.size, c.c2.size)
    }
    fun price(c: Client):arrayOfInt{
        prices = []
        prices.append(car.price(c.c1,c.c2))
        if(transport(c)>=2) {
            prices.append(train.price(c.c1, c.c2))
        } else{prices.append(-1)}
        if(transport(c)==3) {
            prices.append(plane.price(c.c1, c.c2))
        } else{prices.append(-1)}
        return prices
    }
    fun time(c: Client){

    }
}
fun main(){
    var Kazan = City(3)
    var Moscow = City(3)
    var Sibai = City(1)
    var BeliYar = City(1)
    var Zelenodolsk = City(2)
    var cities = arrayOf(Kazan, Moscow, Sibai, BeliYar, Zelenodolsk)
    for(elem in cities){
        elem.weather = Random.nextBoolean()
    }
    for(i in 0 until cities.size-1)
        for(j in i+1 until cities.size)
            cities[i].dist(cities[j])

}
