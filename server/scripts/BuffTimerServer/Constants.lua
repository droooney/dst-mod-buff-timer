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
    COMPOST_WRAP = "COMPOST_WRAP",
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
    COMPOST_WRAP = "compostwrap",
}

local BuffTimerName = {
    SPICE_CHILI = "buffover",
    SPICE_GARLIC = "buffover",
    SPICE_HONEY = "buffover",
    VOLT_GOAT_JELLY = "buffover",
    MUSHY_CAKE = "buffover",
    FISH_CORDON_BLEU = "buffover",
    JELLYBEANS = "regenover",
    SOOTHING_TEA = "regenover",
    TILLWEED_SALVE = "regenover",
    COMPOST_WRAP = "regenover",
}

local BuffByPrefab = {
    buff_attack = BuffType.SPICE_CHILI,
    buff_workeffectiveness = BuffType.SPICE_HONEY,
    buff_playerabsorption = BuffType.SPICE_GARLIC,
    buff_electricattack = BuffType.VOLT_GOAT_JELLY,
    buff_sleepresistance = BuffType.MUSHY_CAKE,
    buff_moistureimmunity = BuffType.FISH_CORDON_BLEU,
    healthregenbuff = BuffType.JELLYBEANS,
    sweettea_buff = BuffType.SOOTHING_TEA,
    firenettle_toxin = BuffType.FIRE_NETTLES,
    tillweedsalve_buff = BuffType.TILLWEED_SALVE,
    compostheal_buff = BuffType.COMPOST_WRAP,
}

return {
    BuffType = BuffType,
    BuffImagePrefab = BuffImagePrefab,
    BuffTimerName = BuffTimerName,
    BuffByPrefab = BuffByPrefab,
}
