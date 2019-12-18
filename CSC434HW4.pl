/* 
Author: Ryan Bouffard
Date: 11-18-19
Description: Guessing game where the user thinks of a thing, and the program asks a series of questions to determine what the thing is.
 */ 


/* 
Author: Ryan Bouffard
Date: 11-12-19
Description: From line 14-140 attributes and relationships are creates to distinguish each element.
 */ 
 
type(rabbit, animal).
type(dog, animal).
type(snake, animal).
type(fish, animal).
type(whale, animal).
type(dinosaur, animal).
type(carrot,plant).
type(orange,plant).
type(seaweed,plant).
type(coral,plant).
type(computer,object).
type(car,object).
type(boat,object).
type(submarine,object).
type(cup,object).
type(lion,animal).
type(rose,plant).
type(horse,animal).
type(chicken,animal).
type(shark,animal).
type(eagle,animal).
type(pencil,object).
type(ant,animal).
type(starfish,animal).
type(pterodactyl,animal).
type(plant_fossil,plant).
type(ammonite_fossil,animal).
type(aquatic_plant_fossil,plant).
type(rubber_duck,object).
type(soapberry,plant).

/* not sure if i need to change coral to animal or not */

alive(rabbit).
alive(dog).
alive(snake).
alive(fish).
alive(whale).
alive(carrot).
alive(orange).
alive(seaweed).
alive(coral).
alive(lion).
alive(rose).
alive(horse).
alive(chicken).
alive(shark).
alive(eagle).
alive(ant).
alive(starfish).
alive(soapberry).

dead(plant_fossil).
dead(aquatic_plant_fossil).
dead(pterodactyl).
dead(ammonite_fossil).
dead(dinosaur).

mammal(rabbit).
mammal(dog).
mammal(whale).
mammal(horse).
mammal(lion).

machine(computer).
machine(car).
machine(boat).
machine(submarine).

water(fish).
water(whale).
water(seaweed).
water(coral).
water(boat).
water(submarine).
water(shark).
water(starfish).
water(ammonite_fossil).
water(aquatic_plant_fossil).
water(rubber_duck).

underwater(submarine).

flight(pterodactyl).
flight(chicken).
flight(eagle).

predator(eagle).
predator(shark).
predator(dog).
predator(lion).
predator(snake).
predator(starfish).
predator(whale).
predator(ant).

legs(ant).
legs(eagle).
legs(chicken).
legs(starfish).
legs(lion).
legs(rabbit).
legs(dog).
legs(horse).


domesticated(rabbit).
domesticated(dog).
domesticated(horse).
domesticated(chicken).

point(pencil).

transportation(car).
transportation(boat).
transportation(submarine).
transportation(horse).

rock_like(coral).
rock_like(ammonite_fossil).
rock_like(aquatic_plant_fossil).

groundGrowth(carrot).
groundGrowth(rose).

edible(carrot).
edible(orange).


/* 
Author: Ryan Bouffard
Date: 11-18-19
Description: Using nested if-else structures with relationships and attributes, this rule takes user input to determine what the thing is.
 */ 

guess(Thing) :- (ask_type(Type), 
				(((Type==animal);(Type==plant))->(ask_alive(Life);Life=dead)->(ask_water(Water);Water=land)
				->((((Type==plant),(Life==alive),(Water==water))->(ask_rock(CheckRock);CheckRock=notrock),
				report6(Thing,Type,Life,Water,CheckRock))
				;
				(((Type==animal),(Life==dead),(Water==land))->(ask_flight(Flight);Flight=nonflight),
				report8(Thing,Type,Life,Water,Flight))
				;
				((Type==animal),(Life==alive))->
				(ask_mammal(Mammal);Mammal=nonmammal),
				(((Type==animal),(Life==alive),(Water==water),(Mammal==y)),
				report13(Thing,Type,Life,Water,Mammal)
				;
				(((Type==animal),(Life==alive),(Water==land),(Mammal==y))->(ask_domesticated(Domesticated);Domesticated=nondomesticated),
				(((Type==animal),(Life==alive),(Water==land),(Mammal==y),(Domesticated==y))->(ask_transportation(Transport);Transport=nontransport)
				;
				report10(Thing,Type,Life,Water,Mammal,Domesticated)),
				(((Type==animal),(Life==alive),(Mammal==y),(Domesticated==y),(Transport==n))->(ask_predator(Predator);Predator=nonpredatory),
				report9(Thing,Type,Life,Water,Mammal,Domesticated,Transport,Predator)
				;
				report12(Thing,Type,Life,Water,Mammal,Domesticated,Transport)))
				;
				
				(((Type==animal),(Life==alive),(Water==land),(Mammal==n))->(ask_legs(Legs);Legs=nonlegged),
				(((Type==animal),(Life==alive),(Water==land),(Mammal==n),(Legs==n)),
				report15(Thing,Type,Life,Water,Mammal,Legs)
				;
				(((Type==animal),(Life==alive),(Water==land),(Mammal==n),(Legs==y))->(ask_flight(Flight);Flight=nonflight),
				(((Type==animal),(Life==alive),(Water==land),(Mammal==n),(Legs==y),(Flight==y))->(ask_predator(Predator);Predator=nonpredatory),
				report11(Thing,Type,Life,Water,Mammal,Legs,Flight,Predator)
				;
				(((Type==animal),(Life==alive),(Water==land),(Mammal==n),(Legs==y),(Flight==n)),
				report16(Thing,Type,Life,Water,Mammal,Legs,Flight))))))
				;
				(((Type==animal),(Life==alive),(Water==water),(Mammal==n))->(ask_legs(Legs);Legs=nonlegged),
				(((Type==animal),(Life==alive),(Water==water),(Mammal==n),(Legs==n))->(ask_predator(Predator);Predator=nonpredatory),
				report14(Thing,Type,Life,Water,Mammal,Legs,Predator)
				;
				report15(Thing,Type,Life,Water,Mammal,Legs))))
				;
				(((Type==plant),(Life==alive),(Water==land))->(ask_ground(CheckGround);CheckGround=notground),
				(ask_edible(Edible);Edible=nonedible),
				report7(Thing,Type,Life,Water,CheckGround,Edible))
				;
				report1(Thing,Type,Life,Water)))
				;
				Type=object,
				((((ask_machine(Machine);Machine=nonmachine)->(ask_water(Water);Water=land)
				->((((Machine==machine),(Water==land))->(ask_transportation(Transport);Transport=nontransport),
				report3(Thing,Type,Machine,Water,Transport))
				;(((Machine==machine),(Water==water))->(ask_underwater(Underwater);Underwater=abovewater),
				report4(Thing,Type,Machine,Water,Underwater))
				;(((Machine==nonmachine),(Water==land))->(ask_point(Point);Point=nonpoint),
				report2(Thing,Type,Machine,Water,Point))
				;report5(Thing,Type,Machine,Water)))))).

/* 
Author: Ryan Bouffard
Date: 11-14-19
Description: The questions presented to the user that will read in user input, must be correct user input for each question.
 */ 

ask_type(Type) :- writef("Is it an animal, plant, or object? \n"), read(Type).
ask_alive(Life) :- writef("Is it alive or dead? \n"), read(Life).
ask_machine(Machine) :- writef("Is it a machine or a nonmachine? \n"), read(Machine).
ask_water(Water) :- writef("Is it found in the water or on land? \n"), read(Water).
ask_mammal(Mammal) :- writef("Is it a mammal? (y/n) \n"), read(Mammal).
ask_flight(Flight) :- writef("Can it fly? (y/n) \n"), read(Flight).
ask_point(Point) :- writef("Does it have a pointed edge? (y/n) \n"), read(Point).
ask_transportation(Transport) :- writef("Can it be used for transportation? (y/n) \n"), read(Transport).
ask_underwater(Underwater) :- writef("Can it dive underwater? (y/n) \n"), read(Underwater).
ask_rock(CheckRock) :- writef("Does it look like a rock? (y/n) \n"), read(CheckRock).
ask_ground(CheckGround) :- writef("Does it grow in/on the ground? (y/n) \n"), read(CheckGround). 
ask_edible(Edible) :- writef("Do humans consider it edible? (y/n) \n"), read(Edible).
ask_domesticated(Domesticated) :- writef("Have humans domesticated it? (y/n) \n"), read(Domesticated).
ask_legs(Legs) :- writef("Does it have legs? (y/n) \n"), read(Legs).
ask_predator(Predator) :- writef("Does it hunt for prey/recreation? (y/n) \n"), read(Predator).
							
/* 
Author: Ryan Bouffard
Date: 11-18-19
Description: Reports that present information back to the user when an answer is found by using equality and not operators on the user input.
 */ 	
	
report1(Thing,Type,Life,Water) :- type(Thing,Type),
							((Life==alive)->alive(Thing);not(alive(Thing))),
							((Water==water)->water(Thing);not(water(Thing))).
							
report2(Thing,Type,Machine,Water,Point) :- type(Thing,Type),
							((Machine==machine)->machine(Thing);not(machine(Thing))),
							((Water==water)->water(Thing);not(water(Thing))),
							((Point==y)->point(Thing);not(point(Thing))).

report3(Thing,Type,Machine,Water,Transport) :- type(Thing,Type),
							((Machine==machine)->machine(Thing);not(machine(Thing))),
							((Water==water)->water(Thing);not(water(Thing))),
							((Transport==y)->transportation(Thing);not(transportation(Thing))).

report4(Thing,Type,Machine,Water,Underwater) :- type(Thing,Type),
							((Machine==machine)->machine(Thing);not(machine(Thing))),
							((Water==water)->water(Thing);not(water(Thing))),
							((Underwater==y)->underwater(Thing);not(underwater(Thing))).
							
report5(Thing,Type,Machine,Water) :- type(Thing,Type),
							((Machine==machine)->machine(Thing);not(machine(Thing))),
							((Water==water)->water(Thing);not(water(Thing))).

							
report6(Thing,Type,Life,Water,CheckRock) :- type(Thing,Type),
							((Life==alive)->alive(Thing);not(alive(Thing))),
							((Water==water)->water(Thing);not(water(Thing))),
							((CheckRock==y)->rock_like(Thing);not(rock_like(Thing))).

							
report7(Thing,Type,Life,Water,CheckGround,Edible) :- type(Thing,Type),
							((Life==alive)->alive(Thing);not(alive(Thing))),
							((Water==water)->water(Thing);not(water(Thing))),
							((CheckGround==y)->groundGrowth(Thing);not(groundGrowth(Thing))),
							((Edible==y)->edible(Thing);not(edible(Thing))).
							
report8(Thing,Type,Life,Water,Flight) :- type(Thing,Type),
							((Life==alive)->alive(Thing);not(alive(Thing))),
							((Water==water)->water(Thing);not(water(Thing))),
							((Flight==y)->flight(Thing);not(flight(Thing))).
							
report9(Thing,Type,Life,Water,Mammal,Domesticated,Transport,Predator) :- type(Thing,Type),
							((Life==alive)->alive(Thing);not(alive(Thing))),
							((Water==water)->water(Thing);not(water(Thing))),
							((Mammal==y)->mammal(Thing);not(mammal(Thing))),
							((Domesticated==y)->domesticated(Thing);not(domesticated(Thing))),
							((Transport==y)->transportation(Thing);not(transportation(Thing))),
							((Predator==y)->predator(Thing);not(predator(Thing))).
							
report10(Thing,Type,Life,Water,Mammal,Domesticated) :- type(Thing,Type),
							((Life==alive)->alive(Thing);not(alive(Thing))),
							((Water==water)->water(Thing);not(water(Thing))),
							((Mammal==y)->mammal(Thing);not(mammal(Thing))),
							((Domesticated==y)->domesticated(Thing);not(domesticated(Thing))).
							
report11(Thing,Type,Life,Water,Mammal,Legs,Flight,Predator) :- type(Thing,Type),
							((Life==alive)->alive(Thing);not(alive(Thing))),
							((Water==water)->water(Thing);not(water(Thing))),
							((Mammal==y)->mammal(Thing);not(mammal(Thing))),
							((Legs==y)->legs(Thing);not(legs(Thing))),
							((Flight==y)->flight(Thing);not(flight(Thing))),
							((Predator==y)->predator(Thing);not(predator(Thing))).
							
report12(Thing,Type,Life,Water,Mammal,Domesticated,Transport) :- type(Thing,Type),
							((Life==alive)->alive(Thing);not(alive(Thing))),
							((Water==water)->water(Thing);not(water(Thing))),
							((Mammal==y)->mammal(Thing);not(mammal(Thing))),
							((Domesticated==y)->domesticated(Thing);not(domesticated(Thing))),
							((Transport==y)->transportation(Thing);not(transportation(Thing))).					
							
report13(Thing,Type,Life,Water,Mammal) :- type(Thing,Type),
							((Life==alive)->alive(Thing);not(alive(Thing))),
							((Water==water)->water(Thing);not(water(Thing))),
							((Mammal==y)->mammal(Thing);not(mammal(Thing))).

report14(Thing,Type,Life,Water,Mammal,Legs,Predator) :- type(Thing,Type),
							((Life==alive)->alive(Thing);not(alive(Thing))),
							((Water==water)->water(Thing);not(water(Thing))),
							((Mammal==y)->mammal(Thing);not(mammal(Thing))),
							((Legs==y)->legs(Thing);not(legs(Thing))),
							((Predator==y)->predator(Thing);not(predator(Thing))).
							
report15(Thing,Type,Life,Water,Mammal,Legs) :- type(Thing,Type),
							((Life==alive)->alive(Thing);not(alive(Thing))),
							((Water==water)->water(Thing);not(water(Thing))),
							((Mammal==y)->mammal(Thing);not(mammal(Thing))),
							((Legs==y)->legs(Thing);not(legs(Thing))).
							
report16(Thing,Type,Life,Water,Mammal,Legs,Flight) :- type(Thing,Type),
							((Life==alive)->alive(Thing);not(alive(Thing))),
							((Water==water)->water(Thing);not(water(Thing))),
							((Mammal==y)->mammal(Thing);not(mammal(Thing))),
							((Legs==y)->legs(Thing);not(legs(Thing))),
							((Flight==y)->flight(Thing);not(flight(Thing))).
							


