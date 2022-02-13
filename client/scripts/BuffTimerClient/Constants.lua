require("constants")

local BuffType = {
    SPICE_CHILI = "SPICE_CHILI",
    SPICE_GARLIC = "SPICE_GARLIC",
    SPICE_HONEY = "SPICE_HONEY",
    VOLT_GOAT_JELLY = "VOLT_GOAT_JELLY",
    MUSHY_CAKE = "MUSHY_CAKE",
    FISH_CORDON_BLEU = "FISH_CORDON_BLEU",
}

local BuffDuration = {
    SPICE_CHILI = TUNING.BUFF_ATTACK_DURATION,
    SPICE_GARLIC = TUNING.BUFF_PLAYERABSORPTION_DURATION,
    SPICE_HONEY = TUNING.BUFF_WORKEFFECTIVENESS_DURATION,
    VOLT_GOAT_JELLY = TUNING.BUFF_ELECTRICATTACK_DURATION,
    MUSHY_CAKE = TUNING.SLEEPRESISTBUFF_TIME,
    FISH_CORDON_BLEU = TUNING.BUFF_MOISTUREIMMUNITY_DURATION,
}

local BuffImagePrefab = {
    SPICE_CHILI = "spice_chili",
    SPICE_GARLIC = "spice_garlic",
    SPICE_HONEY = "spice_sugar",
    VOLT_GOAT_JELLY = "voltgoatjelly",
    MUSHY_CAKE = "shroomcake",
    FISH_CORDON_BLEU = "frogfishbowl",
}

local BuffByFoodPrefab = {
    voltgoatjelly = BuffType.VOLT_GOAT_JELLY,
    shroomcake = BuffType.MUSHY_CAKE,
    frogfishbowl = BuffType.FISH_CORDON_BLEU,
}

local BuffBySpicePrefab = {
    spice_chili = BuffType.SPICE_CHILI,
    spice_garlic = BuffType.SPICE_GARLIC,
    spice_sugar = BuffType.SPICE_HONEY,
}

return {
    BuffType = BuffType,
    BuffDuration = BuffDuration,
    BuffImagePrefab = BuffImagePrefab,
    BuffByFoodPrefab = BuffByFoodPrefab,
    BuffBySpicePrefab = BuffBySpicePrefab,
}
