/////////////////////////////////////////////////////////////
// ANALYZE ALL IMAGES IN A FOLDER
/////////////////////////////////////////////////////////////

// INPUT THRESHOLD VALUE HERE
threshold = 140;

// TURN WATERSHED ON (true) / OFF (false)
watershed = true;

/////////////////////////////////////////////////////////////

// Select folder of images (1 specific marker) to analyze
inputdir = getDir("Choose an image folder");
list = getFileList(inputdir);

// Batch run macro for every image in folder
setBatchMode("hide");

for (i=0; i<list.length; i++) {
  open(inputdir+list[i]);
  run("Split Channels");
  run("Mean...", "radius=1.5");
  setThreshold(0, threshold);
  setOption("BlackBackground", false);
  run("Convert to Mask");

  // Run watershed if set to true
  if (watershed)
    run("Watershed");

  run("Set Measurements...", "area centroid redirect=None decimal=3");

  // Increase min particle size for larger magnifications
  if (matches(list[i], ".*X50.*"))
    run("Analyze Particles...", "size=50-Infinity show=Outlines display clear exclude summarize");
  else
    run("Analyze Particles...", "size=10-Infinity show=Outlines display clear exclude summarize");
  
  // Extract "Area" column from results into areas array
  areas = newArray(nResults());
  for (y=0;y<nResults();y++){
    areas[y] =  getResult("Area", y);
  }

  // Determine median of areas
  Array.sort(areas);
  middle = Math.floor(areas.length/2);
  if (areas.length == 0)
    median = 0;
  else if (areas.length % 2 == 0)
    median = (areas[middle-1] + areas[middle])/2;
  else
    median = areas[middle];

  // Rename "Summary" window to "Results" so it can be modified and exported
  // Add "Median" column to Summary window
  Table.rename("Summary","Results");
  setResult("Median Area", nResults-1, median);

  // Check if "Read and Write Excel" plugin is installed
  // If yes, export Summary into Excel sheet
  List.setCommands;
  if (List.get("Read and Write Excel") != "")
    run("Read and Write Excel", "no_count_column stack_results dataset_label=[" + list[i] + "]");
}