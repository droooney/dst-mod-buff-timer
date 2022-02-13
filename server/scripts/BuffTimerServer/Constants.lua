require("constants")

local BuffType = {
    SPICE_CHILI = "SPICE_CHILI",
    SPICE_GARLIC = "SPICE_GARLIC",
    SPICE_HONEY = "SPICE_HONEY",
    VOLT_GOAT_JELLY = "VOLT_GOAT_JELLY",
    MUSHY_CAKE = "MUSHY_CAKE",
    FISH_CORDON_BLEU = "FISH_CORDON_BLEU",
}

local BuffImagePrefab = {
    SPICE_CHILI = "spice_chili",
    SPICE_GARLIC = "spice_garlic",
    SPICE_HONEY = "spice_sugar",
    VOLT_GOAT_JELLY = "voltgoatjelly",
    MUSHY_CAKE = "shroomcake",
    FISH_CORDON_BLEU = "frogfishbowl",
}

local BuffByPrefab = {
    attack = BuffType.SPICE_CHILI,
    workeffectiveness = BuffType.SPICE_HONEY,
    playerabsorption = BuffType.SPICE_GARLIC,
    electricattack = BuffType.VOLT_GOAT_JELLY,
    sleepresistance = BuffType.MUSHY_CAKE,
    moistureimmunity = BuffType.FISH_CORDON_BLEU,
}

return {
    BuffType = BuffType,
    BuffImagePrefab = BuffImagePrefab,
    BuffByPrefab = BuffByPrefab,
}
