require("constants")

local BuffType = {
    SPICE_CHILI = "SPICE_CHILI",
    SPICE_GARLIC = "SPICE_GARLIC",
    SPICE_HONEY = "SPICE_HONEY",
    VOLT_GOAT_GELLY = "VOLT_GOAT_GELLY",
    GLOW_BERRY_MOUSSE = "GLOW_BERRY_MOUSSE",
    MUSHY_CAKE = "MUSHY_CAKE",
    DRAGON_CHILI_SALAD = "DRAGON_CHILI_SALAD",
    ASPARAGAZPACHO = "ASPARAGAZPACHO",
    FISH_CORDON_BLEU = "FISH_CORDON_BLEU",
}

local BuffDuration = {
    SPICE_CHILI = TUNING.BUFF_ATTACK_DURATION,
    SPICE_GARLIC = TUNING.BUFF_PLAYERABSORPTION_DURATION,
    SPICE_HONEY = TUNING.BUFF_WORKEFFECTIVENESS_DURATION,
    VOLT_GOAT_GELLY = TUNING.BUFF_ELECTRICATTACK_DURATION,
    GLOW_BERRY_MOUSSE = TUNING.WORMLIGHT_DURATION * 4,
    MUSHY_CAKE = TUNING.SLEEPRESISTBUFF_TIME,
    DRAGON_CHILI_SALAD = TUNING.BUFF_FOOD_TEMP_DURATION,
    ASPARAGAZPACHO = TUNING.BUFF_FOOD_TEMP_DURATION,
    FISH_CORDON_BLEU = TUNING.BUFF_MOISTUREIMMUNITY_DURATION,
}

local BuffImagePrefab = {
    SPICE_CHILI = "spice_chili",
    SPICE_GARLIC = "spice_garlic",
    SPICE_HONEY = "spice_sugar",
    VOLT_GOAT_GELLY = "voltgoatjelly",
    GLOW_BERRY_MOUSSE = "glowberrymousse",
    MUSHY_CAKE = "shroomcake",
    DRAGON_CHILI_SALAD = "dragonchilisalad",
    ASPARAGAZPACHO = "gazpacho",
    FISH_CORDON_BLEU = "frogfishbowl",
}

local BuffByPrefab = {
    voltgoatjelly = BuffType.VOLT_GOAT_GELLY,
    glowberrymousse = BuffType.GLOW_BERRY_MOUSSE,
    shroomcake = BuffType.MUSHY_CAKE,
    dragonchilisalad = BuffType.DRAGON_CHILI_SALAD,
    gazpacho = BuffType.ASPARAGAZPACHO,
    frogfishbowl = BuffType.FISH_CORDON_BLEU,
}

return {
    BuffType = BuffType,
    BuffDuration = BuffDuration,
    BuffImagePrefab = BuffImagePrefab,
    BuffByPrefab = BuffByPrefab,
}
