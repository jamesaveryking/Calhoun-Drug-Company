#Individual components

contents<-read.csv("updated_will.csv")

#library(ggplot)


names<-c("Mean","Median","Standard Deviation","Range","Occurrences","Largest","Smallest")
stats<-c(mean(contents$Quantity),median(contents$Quantity),sd(contents$Quantity),(max(contents$Quantity)-min(contents$Quantity)),
          nrow(contents),max(contents$Quantity),min(contents$Quantity))
general_statistics_data_frame<-data.frame(names,stats)


NDC_Manufacturers<-sort(unique(substr(contents$NDC,0,5)))
NDC_Types<-sort(unique(substr(contents$NDC,7,9)))

manufacturer_totals<-vector(length = length(NDC_Manufacturers))
types_totals<-vector(length = length(NDC_Types))

for (i in 1:length(NDC_Types))
{
  types_totals[i]<-sum(contents$Quantity[grepl(NDC_Types[i],substr(contents$NDC,7,9))])
}

for (i in 1:length(NDC_Manufacturers))
{
  manufacturer_totals[i]<-sum(contents$Quantity[grepl(NDC_Manufacturers[i],substr(contents$NDC,0,5))])
}

manufacturers<-data.frame(NDC_Manufacturers,manufacturer_totals)
data.frame(NDC_Types,types_totals)
# 
# View(plot(manufacturer_totals,NDC_Manufacturers))
# View(plot(NDC_Types,types_totals))

total_rows<-nrow(contents)
number_selects<-ceiling(total_rows/10)
selects<-matrix(ncol = number_selects) #check if needs to be row
for(i in 1:number_selects)
{
  if(i!=number_selects)
  {
    selects[1,i] = paste((i-1)*10,i*10,sep=":")
  }
  else
  {
    selects[i] = paste((i-1)*10,total_rows,sep=":")
  }
}
#updateSelectInput(session,"NDC_Range",choices = as.list(selects))