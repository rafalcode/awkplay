#!/usr/bin/awk -f
#
# Only print a line in a bed file if its value is over a certain value
#
# No warranty is implied or assumed by this code.  Please send bugs, suggestions etc.
#

BEGIN { 
    # parameters
    FS = "\t"; 
    OFS = "\t"; 
    header = 0;        # does the input have a header? if so how many lines?
    col = 4; # the colum number .. this will need to have a $ or a $() around it to act as a variable
    cov = 1;           # default value
    cou = 0;
    dc = 0; # different chromosomes
    cn=""; # chromosome name

    # now check arguments.
    if (ARGC!=3)  {
       print "Usage: covov.awk <THRESHOLD_COV_VAL> <FILE_TO_ANALYSE>";
       print "Example: covov.awk 5 bamfile_converted_to_cov.bed";
       print "(this will only retain lines with a coverage of 5 or over)";
       exit 1;
    } else {
       cov=ARGV[1];
       print "Your coverage threshold is " cov;
       # we delete because the file to analyse is not part of the script, its implicit in the awk command
       # awk needs the file to know what to loop over. A bit inelegant as far as the script is concerned.
       delete ARGV[1];
    }
}

{
    if(cn!=$1) { # is chrom name different from previous?
        dc += 1; # will count the different chromosomes
    }
    cn=$1;
    if ($col >= cov) { # equal to or greater!
        cou += 1;
        nb2[cn] += $3-$2
    }
    nb[cn] += $3-$2
}

END {
    printf("Total number of lines in coverage file = %i\n", NR);
    printf("Total number of different chromosome/contigs names= %i\n", dc);
    printf("Percentage lines kept: %4.3f\n", 100*cou/NR);
    printf("%.40s\t%.19s\t%.14s\t%.20s\n", "Chromosome/contig", "TotalNBases", "RetainedNBases", "PercentRetained");
    for (c in nb) {
        printf("%.40s\t%19i\t%14i\t%20.2f\n", c, nb[c], nb2[c], 100*nb2[c]/nb[c]);
    }
}
