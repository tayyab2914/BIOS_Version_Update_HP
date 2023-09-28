<?php

/**
 * This function is called on installation and is used to create database schema for the plugin
 */
function extension_install_biosversion()
{
    $commonObject = new ExtensionCommon;

    $commonObject -> sqlQuery("CREATE TABLE IF NOT EXISTS `biosversion` (
                              `ID` INT(11) NOT NULL AUTO_INCREMENT,
                              `HARDWARE_ID` INT(11) NOT NULL,
                              `INSTALLEDBIOSVERSION` VARCHAR(255) DEFAULT NULL,
                              `INSTALLEDBIOSDATE` VARCHAR(255) DEFAULT NULL,
                              `LATESTBIOSVERSION` VARCHAR(255) DEFAULT NULL,
                              `LATESTBIOSDATE` VARCHAR(255) DEFAULT NULL,
                              `ISREQUIREUPDATE` VARCHAR(255) DEFAULT NULL,
                              `INSTALLSTATUS` VARCHAR(255) DEFAULT NULL,
                              PRIMARY KEY  (`ID`, `HARDWARE_ID`)
                            ) ENGINE=INNODB ;");
}

/**
 * This function is called on removal and is used to destroy database schema for the plugin
 */
function extension_delete_biosversion()
{
    $commonObject = new ExtensionCommon;
    $commonObject -> sqlQuery("DROP TABLE `biosversion`;");
}

/**
 * This function is called on plugin upgrade
 */
function extension_upgrade_biosversion()
{

}
