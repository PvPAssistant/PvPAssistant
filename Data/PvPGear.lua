---@class PvpAssistant
local PvpAssistant = select(2, ...)

local GUTIL = PvpAssistant.GUTIL
---@class PvpAssistant.Pvpgear
PvpAssistant.PVPGEAR = {}
  
local vendorData = {
    -- Calderax <Conquest Quartermaster>
vendorID = 199599,
 items = {
    --Helm
      {itemID = 209095, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Silk Guise
      {itemID = 209094, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Silk Hood
      {itemID = 209151, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Leather Helm
      {itemID = 209265, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Plate Helm
      {itemID = 209075, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Silk Hat
      {itemID = 209247, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Chain Faceguard
      {itemID = 209152, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Leather Mask	
      {itemID = 209246, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Chain Helm
      {itemID = 209076, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Silk Cap
      {itemID = 209171, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Leather Mask
      {itemID = 209303, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Plate Helm
      {itemID = 209208, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Chain Helm
      {itemID = 209133, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Leather Mask
      {itemID = 209132, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Leather Helm
      {itemID = 209266, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Plate Helmet
      {itemID = 209170, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Leather Helm
      {itemID = 209113, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Silk Hood
      {itemID = 209189, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Leather Helm
      {itemID = 209114, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Silk Guise
      {itemID = 209190, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Leather Mask
      {itemID = 209227, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Chain Helm
      {itemID = 209228, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Chain Faceguard
      {itemID = 209284, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Plate Helm
      {itemID = 209304, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Plate Helmet
      {itemID = 209209, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Chain Faceguard
      {itemID = 209285, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Plate Helmet
      
      --Necklace
      {itemID = 209342, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Amulet
      {itemID = 209340, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Necklace
      {itemID = 209341, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Pendant
      
      --Shoulders
      {itemID = 209308, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Plate Pauldrons
      {itemID = 209117, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Silk Mantle
      {itemID = 209099, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Silk Amice
      {itemID = 209270, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Plate Pauldrons
      {itemID = 209136, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Leather Spaulders
      {itemID = 209212, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Chain Monnion
      {itemID = 209269, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Plate Shoulders
      {itemID = 209079, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Silk Mantle
      {itemID = 209231, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Chain Monnion
      {itemID = 209156, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Leather Shoulderpads
      {itemID = 209155, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Leather Spaulders
      {itemID = 209251, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Chain Shoulderguard
      {itemID = 209194, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Leather Shoulderpads
      {itemID = 209250, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Chain Monnion
      {itemID = 209175, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Leather Shoulderpads
      {itemID = 209288, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Plate Shoulders
      {itemID = 209289, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Plate Pauldrons
      {itemID = 209307, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Plate Shoulders
      {itemID = 209098, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Silk Mantle
      {itemID = 209193, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Leather Spaulders
      {itemID = 209137, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Leather Shoulderpads
      {itemID = 209080, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Silk Amice
      {itemID = 209174, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Leather Spaulders
      {itemID = 209118, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Silk Amice
      {itemID = 209213, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Chain Shoulderguard
      {itemID = 209232, requirements = {level = 60, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Chain Shoulderguard
      
      --chests
      {itemID = 209107, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Silk Robe
      {itemID = 209221, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Chain Vest
      {itemID = 209069, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Silk Tunic
      {itemID = 209088, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Silk Tunic
      {itemID = 209126, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Leather Robe
      {itemID = 209202, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Chain Robe
      {itemID = 209222, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Chain Tunic
      {itemID = 209259, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Plate Chestguard
      {itemID = 209146, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Leather Jerkin
      {itemID = 209184, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Leather Jerkin
      {itemID = 209298, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Plate Chestplate
      {itemID = 209240, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Chain Vest
      {itemID = 209203, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Chain Vestments
      {itemID = 209260, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Plate Chestplate
      {itemID = 209127, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Leather Vestments
      {itemID = 209297, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Plate Chestguard
      {itemID = 209165, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Leather Jerkin
      {itemID = 209279, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Plate Chestplate
      {itemID = 209241, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Chain Tunic
      {itemID = 209183, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Leather Vest
      {itemID = 209278, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Plate Chestguard
      {itemID = 209070, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Silk Blouse
      {itemID = 209089, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Silk Blouse
      {itemID = 209108, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Silk Vestments
      {itemID = 209164, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Leather Vest
      {itemID = 209145, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Leather Vest

      
      --belts
      {itemID = 209309, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Plate Girdle
      {itemID = 209139, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Leather Strap
      {itemID = 209120, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Silk Belt
      {itemID = 209290, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Plate Girdle
      {itemID = 209272, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Plate Greatbelt
      {itemID = 209271, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Plate Girdle
      {itemID = 209177, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Leather Strap
      {itemID = 209252, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Chain Belt
      {itemID = 209233, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Chain Belt
      {itemID = 209081, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Silk Cord
      {itemID = 209119, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Silk Cord
      {itemID = 209157, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Leather Belt
      {itemID = 209101, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Silk Belt
      {itemID = 209158, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Leather Strap
      {itemID = 209195, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Leather Belt
      {itemID = 209100, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Silk Cord
      {itemID = 209196, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Leather Strap
      {itemID = 209253, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Chain Girdle
      {itemID = 209082, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Silk Belt
      {itemID = 209234, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Chain Girdle
      {itemID = 209215, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Chain Girdle
      {itemID = 209291, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Plate Greatbelt
      {itemID = 209138, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Leather Belt
      {itemID = 209214, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Chain Belt
      {itemID = 209310, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Plate Greatbelt
      {itemID = 209176, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Leather Belt
      
      
     --Legs
     {itemID = 209115, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Silk Leggings
     {itemID = 209078, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Silk Trousers
     {itemID = 209286, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Plate Legguards
     {itemID = 209306, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Plate Wargreaves
     {itemID = 209077, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Silk Leggings
     {itemID = 209192, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Leather Legwraps
     {itemID = 209210, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Chain Leggings
     {itemID = 209248, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Chain Leggings
     {itemID = 209173, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Leather Legwraps
     {itemID = 209134, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Leather Breeches
     {itemID = 209211, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Chain Breeches
     {itemID = 209096, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Silk Leggings
     {itemID = 209154, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Leather Legwraps
     {itemID = 209097, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Silk Trousers
     {itemID = 209230, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Chain Breeches
     {itemID = 209305, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Plate Legguards
     {itemID = 209172, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Leather Breeches
     {itemID = 209229, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Chain Leggings
     {itemID = 209249, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Chain Breeches
     {itemID = 209287, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Plate Tasses
     {itemID = 209268, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Plate Wargreaves
     {itemID = 209116, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Silk Trousers
     {itemID = 209191, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Leather Breeches
     {itemID = 209267, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Plate Legguards
     {itemID = 209135, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, -- Verdant Gladiator's Leather Legwraps
     {itemID = 209153, requirements = {level = 70, currencyID = 1602, currencyAmount = 875}}, --  Verdant Gladiator's Leather Breeches
      
     --Boots 
      
     {itemID = 209072, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Silk Treads
     {itemID = 209261, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Plate Warboots
     {itemID = 209091, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Silk Treads
     {itemID = 209167, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Leather Treads
     {itemID = 209280, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Plate Warboots
     {itemID = 209243, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Chain Boots
     {itemID = 209204, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Chain Sabatons
     {itemID = 209090, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Silk Slippers
     {itemID = 209299, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Plate Warboots
     {itemID = 209129, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Leather Treads
     {itemID = 209281, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Plate Stompers
     {itemID = 209128, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Leather Boots
     {itemID = 209166, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Leather Boots
     {itemID = 209186, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Leather Treads
     {itemID = 209224, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Chain Boots
     {itemID = 209148, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Leather Treads
     {itemID = 209262, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Plate Stompers
     {itemID = 209071, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Silk Slippers
     {itemID = 209110, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Silk Treads
     {itemID = 209223, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Chain Sabatons
     {itemID = 209242, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Chain Sabatons
     {itemID = 209109, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Silk Slippers
     {itemID = 209147, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Leather Boots
     {itemID = 209185, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Leather Boots
     {itemID = 209205, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Chain Boots
     {itemID = 209300, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Plate Stompers

     --Wrists

     {itemID = 209292, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Plate Wristguards
     {itemID = 209273, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Plate Wristguards
     {itemID = 209121, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Silk Wristwraps
     {itemID = 209235, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Chain Wristguards
     {itemID = 209217, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Chain Bracers
     {itemID = 209140, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Leather Wristwraps
     {itemID = 209311, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Plate Wristguards
     {itemID = 209103, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Silk Armbands
     {itemID = 209216, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Chain Wristguards
     {itemID = 209122, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Silk Armbands
     {itemID = 209254, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Chain Wristguards
     {itemID = 209179, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Leather Wristguards
     {itemID = 209312, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Plate Vambraces
     {itemID = 209102, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Silk Wristwraps
     {itemID = 209274, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Plate Vambraces
     {itemID = 209255, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Chain Bracers
     {itemID = 209293, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Plate Vambraces
     {itemID = 209160, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Leather Wristguards
     {itemID = 209083, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Silk Wristwraps
     {itemID = 209236, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Chain Bracers
     {itemID = 209141, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Leather Wristguards
     {itemID = 209178, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Leather Wristwraps
     {itemID = 209197, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Leather Wristwraps
     {itemID = 209198, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Leather Wristguards
     {itemID = 209159, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Leather Wristwraps
     {itemID = 209084, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Silk Armbands

     
     --Gloves
     
     
     {itemID = 209207, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Chain Handguards
     {itemID = 209149, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Leather Gloves
     {itemID = 209111, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Silk Gloves
     {itemID = 209301, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Plate Gauntlets
     {itemID = 209168, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Leather Gloves
     {itemID = 209225, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Chain Gauntlets
     {itemID = 209282, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Plate Gauntlets
     {itemID = 209302, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Plate Handguards
     {itemID = 209073, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Silk Gloves
     {itemID = 209092, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Silk Gloves
     {itemID = 209226, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Chain Handguards
     {itemID = 209244, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Chain Gauntlets
     {itemID = 209245, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Chain Handguards
     {itemID = 209074, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Silk Handwraps
     {itemID = 209150, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Leather Grips
     {itemID = 209188, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Leather Grips
     {itemID = 209263, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Plate Gauntlets
     {itemID = 209283, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Plate Handguards
     {itemID = 209112, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Silk Handwraps
     {itemID = 209130, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Leather Gloves
     {itemID = 209206, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Chain Gauntlets
     {itemID = 209169, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Leather Grips
     {itemID = 209187, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Leather Gloves
     {itemID = 209264, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Plate Handguards
     {itemID = 209093, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Silk Handwraps
     {itemID = 209131, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Leather Grips

     --Rings
 
     {itemID = 209339, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Signet
     {itemID = 209337, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Ring
     {itemID = 209338, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Band
 
 
     --trinkets
     
     {itemID = 209344, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Insignia of Alacrity
     {itemID = 209346, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Medallion
     {itemID = 209343, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Badge of Ferocity
     {itemID = 209345, requirements = {level = 70, currencyID = 1602, currencyAmount = 700}}, -- Verdant Gladiator's Emblem
     {itemID = 209347, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Sigil of Adaptation
     
     
     --Cloaks
     
     {itemID = 209125, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Shawl
     {itemID = 209294, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Cloak
     {itemID = 209163, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Shawl
     {itemID = 209201, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Shawl
     {itemID = 209239, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Shawl
     {itemID = 209295, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Drape
     {itemID = 209124, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Drape
     {itemID = 209218, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Cloak
     {itemID = 209237, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Cloak
     {itemID = 209296, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Shawl
     {itemID = 209181, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Drape
     {itemID = 209086, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Drape
     {itemID = 209105, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Drape
     {itemID = 209144, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Shawl
     {itemID = 209123, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Cloak
     {itemID = 209277, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Shawl
     {itemID = 209315, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Shawl
     {itemID = 209087, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Shawl
     {itemID = 209143, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Drape
     {itemID = 209199, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Cloak
     {itemID = 209257, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Drape
     {itemID = 209314, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Drape
     {itemID = 209104, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Cloak
     {itemID = 209219, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Drape
     {itemID = 209106, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Shawl
     {itemID = 209162, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Drape
     {itemID = 209200, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Drape
     {itemID = 209238, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Drape
     {itemID = 209256, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Cloak
     {itemID = 209258, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Shawl
     {itemID = 209313, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Cloak
     {itemID = 209182, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Shawl
     {itemID = 209085, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Cloak
     {itemID = 209142, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Cloak
     {itemID = 209161, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Cloak
     {itemID = 209220, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Shawl
     {itemID = 209180, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Cloak
     {itemID = 209275, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}}, -- Verdant Gladiator's Cloak
     {itemID = 209276, requirements = {level = 70, currencyID = 1602, currencyAmount = 525}},  -- Verdant Gladiator's Drape
     
     --One-hands
     
     {itemID = 209537, requirements = {level = 70, currencyID = 1602, currencyAmount = 900}}, -- Verdant Gladiator's Warglaive
     {itemID = 209536, requirements = {level = 70, currencyID = 1602, currencyAmount = 900}}, -- Verdant Gladiator's Dagger
     {itemID = 209541, requirements = {level = 70, currencyID = 1602, currencyAmount = 1350}}, -- Verdant Gladiator's Scepter
     {itemID = 209546, requirements = {level = 70, currencyID = 1602, currencyAmount = 900}}, -- Verdant Gladiator's Claws
     {itemID = 209535, requirements = {level = 70, currencyID = 1602, currencyAmount = 900}}, -- Verdant Gladiator's Splitter
     {itemID = 209545, requirements = {level = 70, currencyID = 1602, currencyAmount = 1350}}, -- Verdant Gladiator's Sickle
     {itemID = 209553, requirements = {level = 70, currencyID = 1602, currencyAmount = 900}}, -- Verdant Gladiator's Shotel
     {itemID = 209552, requirements = {level = 70, currencyID = 1602, currencyAmount = 900}}, -- Verdant Gladiator's Sword
     {itemID = 209544, requirements = {level = 70, currencyID = 1602, currencyAmount = 900}}, -- Verdant Gladiator's Axe
     
     --Two hands
     
     {itemID = 209550, requirements = {level = 70, currencyID = 1602, currencyAmount = 1800}}, -- Verdant Gladiator's Greatsword
     {itemID = 209539, requirements = {level = 70, currencyID = 1602, currencyAmount = 1800}}, -- Verdant Gladiator's Staff
     {itemID = 209548, requirements = {level = 70, currencyID = 1602, currencyAmount = 1800}}, -- Verdant Gladiator's Greatstaff
     {itemID = 209538, requirements = {level = 70, currencyID = 1602, currencyAmount = 1800}}, -- Verdant Gladiator's Scythe
     {itemID = 209554, requirements = {level = 70, currencyID = 1602, currencyAmount = 1800}}, -- Verdant Gladiator's Axestaff
     {itemID = 209540, requirements = {level = 70, currencyID = 1602, currencyAmount = 1800}}, -- Verdant Gladiator's Pulverizer
     {itemID = 209547, requirements = {level = 70, currencyID = 1602, currencyAmount = 1800}}, --  erdant Gladiator's Bow
    
    --Offhand and Held in off-Hand
     {itemID = 209543, requirements = {level = 70, currencyID = 1602, currencyAmount = 450}}, -- Verdant Gladiator's Shield
     {itemID = 209549, requirements = {level = 70, currencyID = 1602, currencyAmount = 450}}, -- Verdant Gladiator's Bulwark
     {itemID = 209542, requirements = {level = 70, currencyID = 1602, currencyAmount = 450}}, -- Verdant Gladiator's Censer
    }
}
    
local vendorData = {
     -- Seltherex <Honor Quartermaster>
     vendorID = 199601,
     items = {
    
     {itemID = 209713, requirements = {level = 70, currencyID = 1792, currencyAmount = 875}}, -- Verdant Aspirant's Leather Helm
     {itemID = 209698, requirements = {level = 70, currencyID = 1792, currencyAmount = 875}}, -- Verdant Aspirant's Plate Helm
     {itemID = 209730, requirements = {level = 70, currencyID = 1792, currencyAmount = 875}}, -- Verdant Aspirant's Plate Headguard
     {itemID = 209745, requirements = {level = 70, currencyID = 1792, currencyAmount = 875}}, -- Verdant Aspirant's Leather Mask
     {itemID = 209712, requirements = {level = 70, currencyID = 1792, currencyAmount = 875}}, -- Verdant Aspirant's Chain Helm
     {itemID = 209744, requirements = {level = 70, currencyID = 1792, currencyAmount = 875}}, -- Verdant Aspirant's Chain Headguard
     {itemID = 209743, requirements = {level = 70, currencyID = 1792, currencyAmount = 875}}, -- Verdant Aspirant's Silk Cover
     {itemID = 209711, requirements = {level = 70, currencyID = 1792, currencyAmount = 875}},  -- Verdant Aspirant's Silk Hood

     --Necklaces
     {itemID = 209771, requirements = {level = 70, currencyID = 1792, currencyAmount = 525}}, -- Verdant Aspirant's Necklace
     {itemID = 209773, requirements = {level = 70, currencyID = 1792, currencyAmount = 525}}, -- Verdant Aspirant's Pendant
     {itemID = 209772, requirements = {level = 70, currencyID = 1792, currencyAmount = 525}}, -- Verdant Aspirant's Choker
    
     --Shoulders
    
     {itemID = 209718, requirements = {level = 70, currencyID = 1792, currencyAmount = 700}}, -- Verdant Aspirant's Leather Spaulders
     {itemID = 209720, requirements = {level = 70, currencyID = 1792, currencyAmount = 700}}, -- Verdant Aspirant's Silk Mantle
     {itemID = 209721, requirements = {level = 70, currencyID = 1792, currencyAmount = 700}}, -- Verdant Aspirant's Chain Spaulders
     {itemID = 209751, requirements = {level = 70, currencyID = 1792, currencyAmount = 700}}, -- Verdant Aspirant's Leather Mantle
     {itemID = 209752, requirements = {level = 70, currencyID = 1792, currencyAmount = 700}}, -- Verdant Aspirant's Plate Pauldrons
     {itemID = 209754, requirements = {level = 70, currencyID = 1792, currencyAmount = 700}}, -- Verdant Aspirant's Chain Shoulderguards
     {itemID = 209753, requirements = {level = 70, currencyID = 1792, currencyAmount = 700}}, -- Verdant Aspirant's Silk Shawl
     {itemID = 209719, requirements = {level = 70, currencyID = 1792, currencyAmount = 700}},  -- Verdant Aspirant's Plate Shoulders
    
    
     --Belts
     {itemID = 209723, requirements = {level = 70, currencyID = 1792, currencyAmount = 700}}, -- Verdant Aspirant's Silk Cord
     {itemID = 209725, requirements = {level = 70, currencyID = 1792, currencyAmount = 700}}, -- Verdant Aspirant's Leather Belt
     {itemID = 209722, requirements = {level = 70, currencyID = 1792, currencyAmount = 700}}, -- Verdant Aspirant's Plate Girdle
     {itemID = 209758, requirements = {level = 70, currencyID = 1792, currencyAmount = 700}}, -- Verdant Aspirant's Leather Cord
     {itemID = 209755, requirements = {level = 70, currencyID = 1792, currencyAmount = 700}}, -- Verdant Aspirant's Plate Greatbelt
     {itemID = 209724, requirements = {level = 70, currencyID = 1792, currencyAmount = 700}}, -- Verdant Aspirant's Chain Belt
     {itemID = 209757, requirements = {level = 70, currencyID = 1792, currencyAmount = 700}}, -- Verdant Aspirant's Chain Clasp
     {itemID = 209756, requirements = {level = 70, currencyID = 1792, currencyAmount = 700}},  -- Verdant Aspirant's Silk Belt
    
     --Legs
     
     {itemID = 209749, requirements = {level = 70, currencyID = 1792, currencyAmount = 875}}, -- Verdant Aspirant's Chain Wargreaves
     {itemID = 209750, requirements = {level = 70, currencyID = 1792, currencyAmount = 875}}, -- Verdant Aspirant's Leather Leggings
     {itemID = 209717, requirements = {level = 70, currencyID = 1792, currencyAmount = 875}}, -- Verdant Aspirant's Leather Breeches
     {itemID = 209715, requirements = {level = 70, currencyID = 1792, currencyAmount = 875}}, -- Verdant Aspirant's Silk Leggings
     {itemID = 209716, requirements = {level = 70, currencyID = 1792, currencyAmount = 875}}, -- Verdant Aspirant's Chain Leggings
     {itemID = 209714, requirements = {level = 70, currencyID = 1792, currencyAmount = 875}}, -- Verdant Aspirant's Plate Legguards
     {itemID = 209746, requirements = {level = 70, currencyID = 1792, currencyAmount = 875}}, -- Verdant Aspirant's Plate Wargreaves
     {itemID = 209747, requirements = {level = 70, currencyID = 1792, currencyAmount = 875}},  -- Verdant Aspirant's Silk Legwraps

     --feet

     {itemID = 209705, requirements = {level = 70, currencyID = 1792, currencyAmount = 700}}, -- Verdant Aspirant's Chain Sabatons
     {itemID = 209703, requirements = {level = 70, currencyID = 1792, currencyAmount = 700}}, -- Verdant Aspirant's Plate Warboots
     {itemID = 209706, requirements = {level = 70, currencyID = 1792, currencyAmount = 700}}, -- Verdant Aspirant's Leather Boots
     {itemID = 209737, requirements = {level = 70, currencyID = 1792, currencyAmount = 700}}, -- Verdant Aspirant's Chain Stompers
     {itemID = 209738, requirements = {level = 70, currencyID = 1792, currencyAmount = 700}}, -- Verdant Aspirant's Leather Footpads
     {itemID = 209736, requirements = {level = 70, currencyID = 1792, currencyAmount = 700}}, -- Verdant Aspirant's Silk Footwraps
     {itemID = 209704, requirements = {level = 70, currencyID = 1792, currencyAmount = 700}}, -- Verdant Aspirant's Silk Treads
     {itemID = 209735, requirements = {level = 70, currencyID = 1792, currencyAmount = 700}},  -- Verdant Aspirant's Plate Stompers
    
    
     --Wrists
    
     {itemID = 209759, requirements = {level = 70, currencyID = 1792, currencyAmount = 525}}, -- Verdant Aspirant's Silk Bindings
     {itemID = 209762, requirements = {level = 70, currencyID = 1792, currencyAmount = 525}}, -- Verdant Aspirant's Leather Armguards
     {itemID = 209729, requirements = {level = 70, currencyID = 1792, currencyAmount = 525}}, -- Verdant Aspirant's Leather Wristwraps
     {itemID = 209726, requirements = {level = 70, currencyID = 1792, currencyAmount = 525}}, -- Verdant Aspirant's Silk Wristwraps
     {itemID = 209760, requirements = {level = 70, currencyID = 1792, currencyAmount = 525}}, -- Verdant Aspirant's Plate Armguards
     {itemID = 209728, requirements = {level = 70, currencyID = 1792, currencyAmount = 525}}, -- Verdant Aspirant's Chain Wristwraps
     {itemID = 209761, requirements = {level = 70, currencyID = 1792, currencyAmount = 525}}, -- Verdant Aspirant's Chain Bracer
     {itemID = 209727, requirements = {level = 70, currencyID = 1792, currencyAmount = 525}},  -- Verdant Aspirant's Plate Cuffs
    
     --Hands
    
     {itemID = 209707, requirements = {level = 70, currencyID = 1792, currencyAmount = 700}}, -- Verdant Aspirant's Leather Gloves
     {itemID = 209742, requirements = {level = 70, currencyID = 1792, currencyAmount = 700}}, -- Verdant Aspirant's Chain Handguards
     {itemID = 209740, requirements = {level = 70, currencyID = 1792, currencyAmount = 700}}, -- Verdant Aspirant's Plate Handguards
     {itemID = 209710, requirements = {level = 70, currencyID = 1792, currencyAmount = 700}}, -- Verdant Aspirant's Chain Gauntlets
     {itemID = 209709, requirements = {level = 70, currencyID = 1792, currencyAmount = 700}}, -- Verdant Aspirant's Silk Gloves
     {itemID = 209739, requirements = {level = 70, currencyID = 1792, currencyAmount = 700}}, -- Verdant Aspirant's Leather Grips
     {itemID = 209708, requirements = {level = 70, currencyID = 1792, currencyAmount = 700}}, -- Verdant Aspirant's Plate Gauntlets
     {itemID = 209741, requirements = {level = 70, currencyID = 1792, currencyAmount = 700}},  -- Verdant Aspirant's Silk Handwraps
    
     --Fingers
     {itemID = 209770, requirements = {level = 70, currencyID = 1792, currencyAmount = 525}}, -- Verdant Aspirant's Signet
     {itemID = 209768, requirements = {level = 70, currencyID = 1792, currencyAmount = 525}}, -- Verdant Aspirant's Ring
     {itemID = 209769, requirements = {level = 70, currencyID = 1792, currencyAmount = 525}},  -- Verdant Aspirant's Band

     --Trinkets

     {itemID = 209764, requirements = {level = 70, currencyID = 1792, currencyAmount = 525}}, -- Verdant Aspirant's Medallion
     {itemID = 209765, requirements = {level = 70, currencyID = 1792, currencyAmount = 700}}, -- Verdant Aspirant's Insignia of Alacrity
     {itemID = 209763, requirements = {level = 70, currencyID = 1792, currencyAmount = 700}}, -- Verdant Aspirant's Badge of Ferocity
     {itemID = 209766, requirements = {level = 70, currencyID = 1792, currencyAmount = 700}}, -- Verdant Aspirant's Emblem
     {itemID = 209767, requirements = {level = 70, currencyID = 1792, currencyAmount = 525}}, -- Verdant Aspirant's Sigil of Adaptation

     --Cloaks
     {itemID = 209776, requirements = {level = 70, currencyID = 1792, currencyAmount = 525}}, -- Verdant Aspirant's Cape
     {itemID = 209775, requirements = {level = 70, currencyID = 1792, currencyAmount = 525}}, -- Verdant Aspirant's Drape
     {itemID = 209777, requirements = {level = 70, currencyID = 1792, currencyAmount = 525}}, -- Verdant Aspirant's Greatcloak
     {itemID = 209774, requirements = {level = 70, currencyID = 1792, currencyAmount = 525}}, -- Verdant Aspirant's Cloak

     --One-Hands, Two-Hands, Ranged, Off Hand And Held in Off-Hand
     {itemID = 210162, requirements = {level = 70, currencyID = 1792, currencyAmount = 875}}, -- Verdant Aspirant's Hammer
     {itemID = 210149, requirements = {level = 70, currencyID = 1792, currencyAmount = 875}}, -- Verdant Aspirant's Battleaxe
     {itemID = 210157, requirements = {level = 70, currencyID = 1792, currencyAmount = 1325}}, -- Verdant Aspirant's Scepter
     {itemID = 210164, requirements = {level = 70, currencyID = 1792, currencyAmount = 875}}, -- Verdant Aspirant's Sword
     {itemID = 210150, requirements = {level = 70, currencyID = 1792, currencyAmount = 875}}, -- Verdant Aspirant's Dagger
     {itemID = 210151, requirements = {level = 70, currencyID = 1792, currencyAmount = 875}}, -- Verdant Aspirant's Mace
     {itemID = 210163, requirements = {level = 70, currencyID = 1792, currencyAmount = 1325}}, -- Verdant Aspirant's Knife
     {itemID = 210166, requirements = {level = 70, currencyID = 1792, currencyAmount = 875}}, -- Verdant Aspirant's Blade
     {itemID = 210156, requirements = {level = 70, currencyID = 1792, currencyAmount = 875}},  -- Verdant Aspirant's Warglaive
     {itemID = 210153, requirements = {level = 70, currencyID = 1792, currencyAmount = 1750}}, -- Verdant Aspirant's Staff
     {itemID = 210154, requirements = {level = 70, currencyID = 1792, currencyAmount = 1750}}, -- Verdant Aspirant's Greatsword
     {itemID = 210152, requirements = {level = 70, currencyID = 1792, currencyAmount = 1750}}, -- Verdant Aspirant's Polearm
     {itemID = 210161, requirements = {level = 70, currencyID = 1792, currencyAmount = 1750}},  -- Verdant Aspirant's Halberd
     {itemID = 210160, requirements = {level = 70, currencyID = 1792, currencyAmount = 1750}}, -- Verdant Aspirant's Recurve
     {itemID = 210317, requirements = {level = 70, currencyID = 1792, currencyAmount = 1325}}, -- Verdant Aspirant's Wand
     {itemID = 210158, requirements = {level = 70, currencyID = 1792, currencyAmount = 425}}, -- Verdant Aspirant's Shield
     {itemID = 210155, requirements = {level = 70, currencyID = 1792, currencyAmount = 425}},  -- Verdant Aspirant's Torch
    }
}


