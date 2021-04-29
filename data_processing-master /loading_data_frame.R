library(ggplot2)
library(plyr)
library(readxl)

### https://clayford.github.io/dwir/dwr_05_combine_merge_rehsape_data.html

data_folder_path ='/home/vm-ds-admin/Unimelb Data/'

## Sourcing initial weightings
weighting <- read_csv('/home/patrick/workspace/weighting.csv')

### Loading file "Archibus_Floors copy.xlsx"
Archibus_Floors <- read_excel(path = '/home/vm-ds-admin/Unimelb Data/Archibus_Floors copy.xlsx', skip = 2)

### Loading file "Archibus_Room Categories &amp; Types copy.xlsx"
Archibus_Room_Categories <- read_excel(path = '/home/vm-ds-admin/Unimelb Data/Archibus_Room Categories &amp; Types copy.xlsx',sheet = 'Categories',skip = 2)
Archibus_Room_Types <- read_excel(path = '/home/vm-ds-admin/Unimelb Data/Archibus_Room Categories &amp; Types copy.xlsx',sheet = 'Types',skip = 2)

### Loading file "Archibus_Rooms copy.xlsx"
Archibus_Rooms <- read_excel(path = '/home/vm-ds-admin/Unimelb Data/Archibus_Rooms copy.xlsx')

### Loading file "Electricity Consumption 2018 V2[2] copy.xlsx"
## Requires some rows to be deleted and requires cleaing for summ - done **
Electricity_Consumption_2018_v2 <- read_excel(path = '/home/vm-ds-admin/Unimelb Data/Electricity Consumption 2018 V2[2] copy.xlsx',skip=8)
Electricity_Consumption_2018_v2 <- Electricity_Consumption_2018_v2[,-c(2,4,6,8,9,10,12,13)]
Electricity_Consumption_2018_v2 <- Electricity_Consumption_2018_v2[1:189,]

Electricity_Consumption_2018_v2_summary <- read_excel(path = '/home/vm-ds-admin/Unimelb Data/Electricity Consumption 2018 V2[2] copy.xlsx',sheet = 'Summ')
Electricity_Consumption_2018_v2_summary <- Electricity_Consumption_2018_v2_summary[-c(1,5,7,8,9),]

### Loading file "Excel Crosstab copy.xlsx"
Crosstab <- read_excel(path = '/home/vm-ds-admin/Unimelb Data/Excel Crosstab copy.xlsx')

## Filling missing values
for (value_index in seq_along(Crosstab$`Bl Id (Rm)`)){
  if (!is.na(Crosstab$`Bl Id (Rm)`[value_index])){
    set_value = Crosstab$`Bl Id (Rm)`[value_index]
    #print (Crosstab$`Bl Id (Rm)`[value_index])
  }
  
  else if (is.na(Crosstab$`Bl Id (Rm)`[value_index])){
    Crosstab$`Bl Id (Rm)`[value_index] <- set_value
  }
}

rm(set_value)
rm(value)
rm(value_index)

### Loading file "Exported Utilities Excel copy.xlsx"
Utilities_Electricity <- read_excel(path = '/home/vm-ds-admin/Unimelb Data/Exported Utilities Excel copy.xlsx', sheet = 'Electricity')
Utilities_Water <- read_excel(path = '/home/vm-ds-admin/Unimelb Data/Exported Utilities Excel copy.xlsx', sheet = 'Water')
Utilities_Gas <- read_excel(path = '/home/vm-ds-admin/Unimelb Data/Exported Utilities Excel copy.xlsx', sheet = 'Gas')

### Loading file "Full Building Address Export copy.xlsx"
Full_Building_Address <- read_excel(path = '/home/vm-ds-admin/Unimelb Data/Full Building Address Export copy.xlsx', skip = 2)

### Loading file "Gas Consumption 2018 copy.xlsx"
Gas_Consumption_2018 <- read_excel(path = '/home/vm-ds-admin/Unimelb Data/Gas Consumption 2018 copy.xlsx',skip=8)
Gas_Consumption_2018 <- Gas_Consumption_2018[,-c(2,4,6,8,9,10,12,13,29,30)]
Gas_Consumption_2018 <- Gas_Consumption_2018[-c(51,52,53),]

### Loading file "Water Consumption 2018 copy.xlsx"
Water_Consumption_2018 <- read_excel(path = '/home/vm-ds-admin/Unimelb Data/Water Consumption 2018 copy.xlsx',skip=8)
Water_Consumption_2018 <- Water_Consumption_2018[,-c(2,4,6,7,8,10,11)]
Water_Consumption_2018 <- Water_Consumption_2018[-c(53,54,55),]
names(Water_Consumption_2018)[names(Water_Consumption_2018) == 43040] <- 'Nov-17'

Water_Consumption_2018_summary <- read_excel(path = '/home/vm-ds-admin/Unimelb Data/Water Consumption 2018 copy.xlsx', sheet = 'Summary')
Water_Consumption_2018_summary <- Water_Consumption_2018_summary[-c(10),]

### Loading file "Shared Teaching Space_2018 Usage_R1.1 (with raw data) copy.xlsx"
Shared_Teaching_Space_2018_Usage_R1.1_Formatted <- read_excel(path = '/home/vm-ds-admin/Unimelb Data/Shared Teaching Space_2018 Usage_R1.1 (with raw data) copy.xlsx', sheet = 'Formatted',range = "A3:G22")
#Shared_Teaching_Space_2018_Usage_R1.1_Seat_hours_by_Division <- read_excel(path = '/home/vm-ds-admin/Unimelb Data/Shared Teaching Space_2018 Usage_R1.1 (with raw data) copy.xlsx', sheet = 'Seat Hours by Division',range = "A7:C25")
Shared_Teaching_Space_2018_Usage_R1.1_Archibus <- read_excel(path = '/home/vm-ds-admin/Unimelb Data/Shared Teaching Space_2018 Usage_R1.1 (with raw data) copy.xlsx', sheet = 'Archibus',range = "A1:S867")
Shared_Teaching_Space_2018_Usage_R1.1_S_Capacity <- read_excel(path = '/home/vm-ds-admin/Unimelb Data/Shared Teaching Space_2018 Usage_R1.1 (with raw data) copy.xlsx', sheet = 'S+ Capacity',range = "A1:B970")

## Requires data type cleaning especially for data types
Shared_Teaching_Space_2018_Usage_R1.1_Raw_Data <- read_xlsx(path = '/home/vm-ds-admin/Unimelb Data/Shared Teaching Space_2018 Usage_R1.1 (with raw data) copy.xlsx', sheet = 'Raw Data',range = "A1:DG77956", col_types = "text")

### Loading file "2018_backlog_maintenance_room_20052019 copy"
backlog_maintenance_room_20052019_2018 <- read_xlsx(path = '/home/akash/2018_backlog_maintenance_room_20052019 copy.xlsx')

### Uploading new weightings
new_weightings <- read_xlsx(path = '/home/akash/Pure Weightings_v1.xlsx')
colnames(new_weightings) <- colnames(weighting)
