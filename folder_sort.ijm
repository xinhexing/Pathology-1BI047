/////////////////////////////////////////////////////////////
// SORT IMAGES INTO TREATMENT FOLDERS
/////////////////////////////////////////////////////////////

// LIST TREATMENTS HERE
treatments = newArray("BrdU","Caspase-3","CD68");

/////////////////////////////////////////////////////////////

// Choose raw image directory
sortdir = getDir("Choose folder to sort");
sortlist = getFileList(sortdir);

// Create directories for treatments
for (i=0; i<treatments.length; i++) {
  File.makeDirectory(sortdir + treatments[i]);
}

for (i=0; i<sortlist.length; i++) {
  for (x=0; x<treatments.length; x++) {
    if (matches(sortlist[i], ".*" + treatments[x] + ".*"))
      File.copy(sortdir + sortlist[i], sortdir + treatments[x] + "/" + sortlist[i]);
  }
}