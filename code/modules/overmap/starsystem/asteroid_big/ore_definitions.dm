
/ore
	var/vein_type
	var/vein_colour
	var/ore_product
	var/ore_byproduct
	var/ore_type = 1
	var/rock
	var/byproduct_amount = 0.25
	var/spawn_weight = 2		//1-3
	var/vein_size = 2			//1-3

/ore/argentite
	name = "argentite"
	display_name = "argentite"
	result_amount = 1
	spread_chance = 20
	vein_type = 5
	vein_colour = "#999999"
	ore_product = "lead"
	ore_byproduct = "silver"
	ore_type = 1

/ore/augite
	name = "augite"
	display_name = "augite"
	result_amount = 1
	spread_chance = 20
	vein_type = 5
	vein_colour = "#CCCCCC"
	spawn_weight = 3
	ore_product = "aluminium"
	ore_byproduct = "nickel"
	ore_type = 2

/ore/aurocupride
	name = "aurocupride"
	display_name = "aurocupride"
	result_amount = 1
	spread_chance = 10
	vein_type = 6
	vein_colour = "#CCDD11"
	ore_product = "copper"
	ore_byproduct = "gold"
	ore_type = 1

/ore/azurite
	name = "azurite"
	display_name = "azurite"
	result_amount = 1
	spread_chance = 20
	vein_type = 4
	vein_colour = "#0033AA"
	spawn_weight = 3
	ore_product = "copper"
	ore_byproduct = "molybdenum"
	ore_type = 1

/ore/baryte
	name = "baryte"
	display_name = "baryte"
	result_amount = 1
	spread_chance = 20
	vein_type = 3
	vein_colour = "#334466"
	vein_size = 1
	ore_product = "barium"
	ore_type = 1

/ore/bauxite
	name = "bauxite"
	display_name = "bauxite"
	result_amount = 1
	spread_chance = 20
	vein_type = 1
	vein_colour = "#660055"
	spawn_weight = 3
	ore_product = "aluminium"
	ore_byproduct = "boron"
	ore_type = 1

/ore/bismuthinite
	name = "bismuthinite"
	display_name = "bismuthinite"
	result_amount = 1
	spread_chance = 25
	vein_type = 1
	vein_colour = "#664466"
	spawn_weight = 2
	vein_size = 1
	ore_product = "bismuth"
	ore_type = 1

/ore/boracite
	name = "boracite"
	display_name = "boracite"
	result_amount = 1
	spread_chance = 10
	vein_type = 2
	vein_colour = "#667755"
	ore_product = "boron"
	ore_byproduct = "magnesium"
	ore_type = 2

/ore/celestine
	name = "celestine"
	display_name = "celestine"
	result_amount = 1
	spread_chance = 20
	vein_type = 6
	vein_colour = "#66DDBB"
	spawn_weight = 1
	vein_size = 1
	ore_product = "strontium"
	ore_type = 2

/ore/chromite
	name = "chromite"
	display_name = "chromite"
	result_amount = 1
	spread_chance = 30
	vein_type = 3
	vein_colour = "#CCAACC"
	vein_size = 1
	ore_product = "chromium"
	ore_type = 2

/ore/cobaltite
	name = "cobaltite"
	display_name = "cobaltite"
	result_amount = 1
	spread_chance = 20
	vein_type = 5
	vein_colour = "#000033"
	spawn_weight = 2
	vein_size = 1
	ore_product = "cobalt"
	ore_type = 3

/ore/cooperite
	name = "cooperite"
	display_name = "cooperite"
	result_amount = 1
	spread_chance = 10
	vein_type = 1
	vein_colour = "#FFFFFF"
	spawn_weight = 1
	ore_product = "platinum"
	ore_byproduct = "rhodium"
	ore_type = 6

/ore/dilithium
	name = "dilithium"
	display_name = "dilithium"
	result_amount = 1
	spread_chance = 20
	vein_type = 3
	vein_colour = "#667700"
	ore_product = "lithium"
	ore_byproduct = "ruthenium"
	ore_type = 2

/ore/electrum
	name = "electrum"
	display_name = "electrum"
	result_amount = 1
	spread_chance = 10
	vein_type = 1
	vein_colour = "#FFFFDD"
	vein_size = 1
	ore_product = "gold"
	ore_byproduct = "silver"
	byproduct_amount = 0.5
	ore_type = 3

/ore/gold
	name = "gold"
	display_name = "gold"
	result_amount = 1
	spread_chance = 10
	vein_type = 1
	vein_colour = "#FFFF00"
	spawn_weight = 1
	vein_size = 1
	ore_product = "gold"
	ore_type = 4

/ore/hercynite
	name = "hercynite"
	display_name = "hercynite"
	result_amount = 1
	spread_chance = 10
	vein_type = 5
	vein_colour = "#993300"
	spawn_weight = 1
	ore_product = "tungsten"
	ore_byproduct = "selenium"
	ore_type = 4

/ore/ilmenite
	name = "ilmenite"
	display_name = "ilmenite"
	result_amount = 1
	spread_chance = 20
	vein_type = 5
	vein_colour = "#660000"
	spawn_weight = 3
	ore_product = "iron"
	ore_byproduct = "titanium"
	ore_type = 5

/ore/isocryte
	name = "isocryte"
	display_name = "isocryte"
	result_amount = 1
	spread_chance = 20
	vein_type = 1
	vein_colour = "#001122"
	spawn_weight = 1
	ore_product = "vanadium"
	ore_byproduct = "graphite"
	ore_type = 5

/ore/kamacite
	name = "kamacite"
	display_name = "kamacite"
	result_amount = 1
	spread_chance = 30
	vein_type = 4
	vein_colour = "#993300"
	spawn_weight = 3
	vein_size = 3
	ore_product = "iron"
	ore_byproduct = "cobalt"
	ore_type = 2

/ore/magnesiochromite
	name = "magnesiochromite"
	display_name = "magnesiochromite"
	result_amount = 1
	spread_chance = 20
	vein_type = 4
	vein_colour = "#FF69B4"
	ore_product = "chromium"
	ore_byproduct = "magnesium"
	ore_type = 3

/ore/magnesite
	name = "magnesite"
	display_name = "magnesite"
	result_amount = 1
	spread_chance = 10
	vein_type = 2
	vein_colour = "#999900"
	vein_size = 1
	ore_product = "magnesium"
	ore_type = 3

/ore/molybdenite
	name = "molybdenite"
	display_name = "molybdenite"
	result_amount = 1
	spread_chance = 10
	vein_type = 2
	vein_colour = "#CC6633"
	spawn_weight = 1
	vein_size = 1
	ore_product = "molybdenum"
	ore_type = 4

/ore/ormelite
	name = "ormelite"
	display_name = "ormelite"
	result_amount = 1
	spread_chance = 20
	vein_type = 2
	vein_colour = "#CCCCCC"
	spawn_weight = 1
	ore_product = "platinum"
	ore_byproduct = "osmium"
	ore_type = 2

/ore/pasavaite
	name = "pasavaite"
	display_name = "pasavaite"
	result_amount = 1
	spread_chance = 20
	vein_type = 6
	vein_colour = "#EEEEEE"
	spawn_weight = 1
	ore_product = "platinum"
	ore_byproduct = "palladium"
	ore_type = 2

/ore/phrik
	name = "phrik"
	display_name = "phrik"
	result_amount = 1
	spread_chance = 30
	vein_type = 4
	vein_colour = "#990000"
	spawn_weight = 1
	ore_product = "titanium"
	ore_byproduct = "phosphorus"
	ore_type = 5

/ore/platinum
	name = "platinum"
	display_name = "platinum"
	result_amount = 1
	spread_chance = 20
	vein_type = 4
	vein_colour = "#BBBBBB"
	vein_size = 1
	spawn_weight = 1
	ore_product = "platinum"
	ore_type = 4

/ore/plessite
	name = "plessite"
	display_name = "plessite"
	result_amount = 1
	spread_chance = 10
	vein_type = 2
	vein_colour = "#666600"
	spawn_weight = 3
	vein_size = 3
	ore_product = "iron"
	ore_byproduct = "phosphorus"
	ore_type = 3

/ore/polarite
	name = "polarite"
	display_name = "polarite"
	result_amount = 1
	spread_chance = 20
	vein_type = 5
	vein_colour = "#DDDDDD"
	vein_size = 1
	ore_product = "platinum"
	ore_byproduct = "ruthenium"
	ore_type = 5
	spawn_weight = 2

/ore/pyroxene
	name = "pyroxene"
	display_name = "pyroxene"
	result_amount = 1
	spread_chance = 20
	vein_type = 6
	vein_colour = "#334466"
	spawn_weight = 3
	vein_size = 3
	ore_product = "bismuth"
	ore_byproduct = "sulfur"
	ore_type = 3

/ore/quadrillium
	name = "quadrillium"
	display_name = "quadrillium"
	result_amount = 1
	spread_chance = 20
	vein_type = 6
	vein_colour = "#664422"
	ore_product = "tungsten"
	ore_byproduct = "cobalt"
	ore_type = 4

/ore/rhodiumriridium
	name = "rhodiumriridium"
	display_name = "rhodiumriridium"
	result_amount = 1
	spread_chance = 20
	vein_type = 2
	vein_colour = "#FF7700"
	spawn_weight = 1
	ore_product = "rhodium"
	ore_byproduct = "iridium"
	ore_type = 6
	byproduct_amount = 0.5

/ore/silver
	name = "silver"
	display_name = "silver"
	result_amount = 1
	spread_chance = 20
	vein_type = 3
	vein_colour = "#999999"
	spawn_weight = 1
	vein_size = 1
	ore_product = "silver"
	ore_type = 4

/ore/sperrylite
	name = "sperrylite"
	display_name = "sperrylite"
	result_amount = 1
	spread_chance = 10
	vein_type = 3
	vein_colour = "#AAAAAA"
	spawn_weight = 1
	ore_product = "platinum"
	ore_byproduct = "iridium"
	ore_type = 5

/ore/sylvanite
	name = "sylvanite"
	display_name = "sylvanite"
	result_amount = 1
	spread_chance = 10
	vein_type = 4
	vein_colour = "#664466"
	spawn_weight = 1
	ore_product = "tellurium"
	ore_byproduct = "graphite"
	ore_type = 6

/ore/taenite
	name = "augite"
	display_name = "taenite"
	result_amount = 1
	spread_chance = 30
	vein_type = 6
	vein_colour = "#666600"
	spawn_weight = 3
	vein_size = 3
	ore_product = "rhodium"
	ore_byproduct = "iridium"
	ore_type = 5

/ore/tellurite
	name = "tellurite"
	display_name = "tellurite"
	result_amount = 1
	spread_chance = 10
	vein_type = 3
	vein_colour = "#999900"
	vein_size = 1
	ore_product = "tellurium"
	ore_type = 6

/ore/tellurobismuthite
	name = "tellurobismuthite"
	display_name = "tellurobismuthite"
	result_amount = 1
	spread_chance = 20
	vein_type = 1
	vein_colour = "#FF7700"
	ore_product = "tellurium"
	ore_byproduct = "bismuth"
	ore_type = 1

/ore/trellium
	name = "trellium"
	display_name = "trellium"
	result_amount = 1
	spread_chance = 30
	vein_type = 3
	vein_colour = "#993300"
	spawn_weight = 1
	ore_product = "tungsten"
	ore_byproduct = "lead"
	ore_type = 3

/ore/triphylite
	name = "triphylite"
	display_name = "triphylite"
	result_amount = 1
	spread_chance = 20
	vein_type = 5
	vein_colour = "#999900"
	vein_size = 3
	ore_product = "nickel"
	ore_byproduct = "potassium"
	ore_type = 6

/ore/vanadinite
	name = "vanadinite"
	display_name = "vanadinite"
	result_amount = 1
	spread_chance = 10
	vein_type = 6
	vein_colour = "#002222"
	spawn_weight = 1
	vein_size = 1
	ore_product = "vanadium"
	ore_type = 6

/ore/veldspar
	name = "veldspar"
	display_name = "veldspar"
	result_amount = 1
	spread_chance = 20
	vein_type = 2
	vein_colour = "#666600"
	spawn_weight = 1
	ore_product = "titanium"
	ore_byproduct = "rhenium"
	ore_type = 4

/ore/vulcanite
	name = "vulcanite"
	display_name = "vulcanite"
	result_amount = 1
	spread_chance = 20
	vein_type = 2
	vein_colour = "#FF7700"
	spawn_weight = 3
	ore_product = "copper"
	ore_byproduct = "sulfur"
	ore_type = 2
