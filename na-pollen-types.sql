/* SQL query that pulls North American pollen types names, pollen type IDs, and two columns of higher taxon names for each pollen type
from the Neotoma Paleoecology Database
 By Anna E George

Notes:
- Geographical extent of the sites is defined by the lat/long bounding box but can change this by modifying conditiions in the WHERE clause
- North America Bounding box: W 166°41'00"--W 52°17'00"/N 72°22'00"--N 24°16'00"
                                -166.6833 to -52.28333/72.36667 to 24.26667
- est.ecolsetid = 1 pulls only taxa with a ecolsettype of Default plant */


SELECT DISTINCT taxa.taxonid AS TaxonID, taxa.taxonname AS TaxonName, htaxa1.taxonname AS HigherTaxon1, htaxa2.taxonname AS HigherTaxon2
FROM ndb.sites
    INNER JOIN ndb.collectionunits AS cus    ON sites.siteid         = cus.siteid
    INNER JOIN ndb.analysisunits   AS aus    ON cus.collectionunitid = aus.collectionunitid
    INNER JOIN ndb.samples         AS samp   ON aus.analysisunitid   = samp.analysisunitid
    INNER JOIN ndb.data            AS dat    ON samp.sampleid        = dat.sampleid
    INNER JOIN ndb.variables       AS var    ON dat.variableid       = var.variableid
    INNER JOIN ndb.taxa                      ON var.taxonid          = taxa.taxonid
    INNER JOIN ndb.taxa            AS htaxa1 ON taxa.highertaxonid   = htaxa1.taxonid
    INNER JOIN ndb.taxa            AS htaxa2 ON htaxa1.highertaxonid = htaxa2.taxonid
    INNER JOIN ndb.ecolgroups      AS ecg    ON taxa.taxonid         = ecg.taxonid
    INNER JOIN ndb.ecolsettypes    AS est    ON ecg.ecolsetid        = est.ecolsetid
WHERE est.ecolsetid = 1 AND sites.longitudeeast <= -52.28333 AND sites.longitudewest >= -166.6833
                        AND sites.latitudenorth <= 72.36667  AND sites.latitudesouth >= 24.26667
