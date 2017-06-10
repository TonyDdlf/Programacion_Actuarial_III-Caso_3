bindx <- rbind(read.table("./UCI HAR Dataset/train/X_train.txt"), read.table("./UCI HAR Dataset/test/X_test.txt"))
bindy <- rbind(read.table("./UCI HAR Dataset/train/Y_train.txt"), read.table("./UCI HAR Dataset/test/Y_test.txt"))
bindsub <- rbind(read.table("./UCI HAR Dataset/train/subject_train.txt"), read.table("./UCI HAR Dataset/test/subject_test.txt"))
actividad <- read.table("UCI HAR Dataset/activity_labels.txt")
titulos <- read.table("./UCI HAR Dataset/features.txt")
titulos <- titulos[,2]
names(bindx) <- titulos    ###### agregado para que se vean los nombres de las variables
meds <- grepl('-(mean|std)\\(', titulos)
xmedstd <- bindx[meds == T]
etiquetas <- unsplit(actividad[,2], bindy)
tablaf <- data.frame(bindsub, etiquetas, xmedstd)
promedios <- rbind()
nombres <- c()
for (i in 1:30){
  for (j in as.character(actividad[,2])){
    resultado <- tablaf[(tablaf["V1"]==i) & (tablaf["etiquetas"]==j),]
    fila <- cbind()
    for (k in 3:ncol(resultado)){
      fila <- cbind(fila,mean(resultado[,k]))
    }
    promedios <- rbind(promedios,fila)
    nombres <- c(nombres, paste(i,j,sep = "/"))
  }
}
row.names(promedios) <- nombres
colnames(promedios) <- names(resultado[3:ncol(resultado)])
promedios
dir.create("./orden")
write.csv(tablaf, "./orden/data_orden.csv")
write.table(tablaf, "./orden/data_orden.txt")
write.csv(promedios, "./orden/promedios.csv")
write.table(promedios, "./orden/promedios.txt")