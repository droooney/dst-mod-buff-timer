require("constants")

local BuffType = {
    SPICE_CHILI = "SPICE_CHILI",
    SPICE_GARLIC = "SPICE_GARLIC",
    SPICE_HONEY = "SPICE_HONEY",
    VOLT_GOAT_JELLY = "VOLT_GOAT_JELLY",
    MUSHY_CAKE = "MUSHY_CAKE",
    FISH_CORDON_BLEU = "FISH_CORDON_BLEU",
    JELLYBEANS = "JELLYBEANS",
    SOOTHING_TEA = "SOOTHING_TEA",
    FIRE_NETTLES = "FIRE_NETTLES",
    TILLWEED_SALVE = "TILLWEED_SALVE",
    LESSER_GLOW_BERRY = "LESSER_GLOW_BERRY",
    GLOW_BERRY = "GLOW_BERRY",
    GLOW_BERRY_MOUSSE = "GLOW_BERRY_MOUSSE",
}

local BuffDuration = {
    SPICE_CHILI = TUNING.BUFF_ATTACK_DURATION,
    SPICE_GARLIC = TUNING.BUFF_PLAYERABSORPTION_DURATION,
    SPICE_HONEY = TUNING.BUFF_WORKEFFECTIVENESS_DURATION,
    VOLT_GOAT_JELLY = TUNING.BUFF_ELECTRICATTACK_DURATION,
    MUSHY_CAKE = TUNING.SLEEPRESISTBUFF_TIME,
    FISH_CORDON_BLEU = TUNING.BUFF_MOISTUREIMMUNITY_DURATION,
    JELLYBEANS = TUNING.JELLYBEAN_DURATION,
    SOOTHING_TEA = TUNING.SWEETTEA_DURATION,
    FIRE_NETTLES = TUNING.FIRE_NETTLE_TOXIN_DURATION,
    TILLWEED_SALVE = TUNING.TILLWEEDSALVE_DURATION,
    LESSER_GLOW_BERRY = TUNING.WORMLIGHT_DURATION * 0.25,
    GLOW_BERRY = TUNING.WORMLIGHT_DURATION,
    GLOW_BERRY_MOUSSE = TUNING.WORMLIGHT_DURATION * 4,
}

local BuffImagePrefab = {
    SPICE_CHILI = "spice_chili",
    SPICE_GARLIC = "spice_garlic",
    SPICE_HONEY = "spice_sugar",
    VOLT_GOAT_JELLY = "voltgoatjelly",
    MUSHY_CAKE = "shroomcake",
    FISH_CORDON_BLEU = "frogfishbowl",
    JELLYBEANS = "jellybean",
    SOOTHING_TEA = "sweettea",
    FIRE_NETTLES = "firenettles",
    TILLWEED_SALVE = "tillweedsalve",
    LESSER_GLOW_BERRY = "wormlight_lesser",
    GLOW_BERRY = "wormlight",
    GLOW_BERRY_MOUSSE = "glowberrymousse",
}

local BuffByFoodPrefab = {
    voltgoatjelly = BuffType.VOLT_GOAT_JELLY,
    shroomcake = BuffType.MUSHY_CAKE,
    frogfishbowl = BuffType.FISH_CORDON_BLEU,
    jellybean = BuffType.JELLYBEANS,
    sweettea = BuffType.SOOTHING_TEA,
    firenettles = BuffType.FIRE_NETTLES,
    wormlight_lesser = BuffType.LESSER_GLOW_BERRY,
    wormlight = BuffType.GLOW_BERRY,
    glowberrymousse = BuffType.GLOW_BERRY_MOUSSE,
}

local BuffByHealingPrefab = {
    tillweedsalve = BuffType.TILLWEED_SALVE,
}

local BuffBySpicePrefab = {
    spice_chili = BuffType.SPICE_CHILI,
    spice_garlic = BuffType.SPICE_GARLIC,
    spice_sugar = BuffType.SPICE_HONEY,
}

local OverlappingBuffedFoods = {
    {BuffType.LESSER_GLOW_BERRY, BuffType.GLOW_BERRY, BuffType.GLOW_BERRY_MOUSSE},
}

return {
    BuffType = BuffType,
    BuffDuration = BuffDuration,
    BuffImagePrefab = BuffImagePrefab,
    BuffByFoodPrefab = BuffByFoodPrefab,
    BuffByHealingPrefab = BuffByHealingPrefab,
    BuffBySpicePrefab = BuffBySpicePrefab,
    OverlappingBuffedFoods = OverlappingBuffedFoods,
}
