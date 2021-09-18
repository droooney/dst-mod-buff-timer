require("constants")

local BuffType = {
    SPICE_CHILI = "SPICE_CHILI",
    SPICE_GARLIC = "SPICE_GARLIC",
    SPICE_HONEY = "SPICE_HONEY",
    VOLT_GOAT_GELLY = "VOLT_GOAT_GELLY",
    MUSHY_CAKE = "MUSHY_CAKE",
    FISH_CORDON_BLEU = "FISH_CORDON_BLEU",
}

local BuffDuration = {
    SPICE_CHILI = TUNING.BUFF_ATTACK_DURATION,
    SPICE_GARLIC = TUNING.BUFF_PLAYERABSORPTION_DURATION,
    SPICE_HONEY = TUNING.BUFF_WORKEFFECTIVENESS_DURATION,
    VOLT_GOAT_GELLY = TUNING.BUFF_ELECTRICATTACK_DURATION,
    MUSHY_CAKE = TUNING.SLEEPRESISTBUFF_TIME,
    FISH_CORDON_BLEU = TUNING.BUFF_MOISTUREIMMUNITY_DURATION,
}

local BuffImagePrefab = {
    SPICE_CHILI = "spice_chili",
    SPICE_GARLIC = "spice_garlic",
    SPICE_HONEY = "spice_sugar",
    VOLT_GOAT_GELLY = "voltgoatjelly",
    MUSHY_CAKE = "shroomcake",
    FISH_CORDON_BLEU = "frogfishbowl",
}

local BuffByPrefab = {
    attack = BuffType.SPICE_CHILI,
    workeffectiveness = BuffType.SPICE_HONEY,
    playerabsorption = BuffType.SPICE_GARLIC,
    electricattack = BuffType.VOLT_GOAT_GELLY,
    glowberrymousse = BuffType.GLOW_BERRY_MOUSSE,
    sleepresistance = BuffType.MUSHY_CAKE,
    moistureimmunity = BuffType.FISH_CORDON_BLEU,
}

local BuffBy

return {
    BuffType = BuffType,
    BuffDuration = BuffDuration,
    BuffImagePrefab = BuffImagePrefab,
    BuffByPrefab = BuffByPrefab,
}
