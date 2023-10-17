
package Apache::Ocsinventory::Plugins::Biosversion::Map;
 
use strict;
 
use Apache::Ocsinventory::Map;

$DATA_MAP{biosversion} = {
	mask => 0,
		multi => 1,
		auto => 1,
		delOnReplace => 1,
		sortBy => 'ID',
		writeDiff => 0,
		cache => 0,
		fields => {
            INSTALLEDBIOSVERSION =>{},
            INSTALLEDBIOSDATE =>{},
            LATESTBIOSVERSION =>{},
            LATESTBIOSDATE =>{},
            ISREQUIREUPDATE =>{},
            INSTALLSTATUS =>{},

}
};
1;
