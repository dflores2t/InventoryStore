-- MySQL Script InventoryStore
-- sáb 21 ene 2023 20:33:48
-- Model: New Model    Version: 1.0
--

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `InventoryStore` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `InventoryStore` DEFAULT CHARACTER SET utf8 ;
USE `InventoryStore` ;

-- -----------------------------------------------------
-- Table `mydb`.`Stores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `InventoryStore`.`Stores` ;

CREATE TABLE IF NOT EXISTS `InventoryStore`.`Stores` (
  `IdStore` INT NOT NULL AUTO_INCREMENT,
  `StoreRuc` VARCHAR(14) NOT NULL,
  `StoreName` VARCHAR(45) NOT NULL COMMENT 'Store Name to idetify',
  `StoreEmail` VARCHAR(45) NOT NULL,
  `StoreAddress` VARCHAR(100) NULL,
  `StorePhone` INT NULL,
  `StoreMovil` INT NULL,
  `StoreDateUp` DATETIME NOT NULL,
  `StoresDateModify` DATETIME NULL,
  `StoresDeleted` TINYINT NULL,
  PRIMARY KEY (`IdStore`),
  UNIQUE INDEX `StoreRuc_UNIQUE` (`StoreRuc` ASC) VISIBLE,
  UNIQUE INDEX `StoreEmail_UNIQUE` (`StoreEmail` ASC) VISIBLE,
  UNIQUE INDEX `StorePhone_UNIQUE` (`StorePhone` ASC) VISIBLE,
  UNIQUE INDEX `StoreMovil_UNIQUE` (`StoreMovil` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 1
COMMENT = 'this tablo is to identify each store in the system';


-- -----------------------------------------------------
-- Table `InventoryStore`.`StoreCustomers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `InventoryStore`.`StoreCustomers` ;

CREATE TABLE IF NOT EXISTS `InventoryStore`.`StoreCustomers` (
  `idStoreCustomers` INT NOT NULL,
  `StoreCustomersNames` VARCHAR(45) NULL,
  `StoreCustomersLastNames` VARCHAR(45) NULL,
  `StoreCustomersCellPhone` INT NOT NULL,
  `StoreCustomersAddress` VARCHAR(200) NULL,
  `StoreCustomersEmail` VARCHAR(45) NOT NULL,
  `StoreCustomersDateUp` DATETIME NOT NULL,
  `StoreCustomersDateModify` DATETIME NOT NULL,
  `StoreCustomersDeleted` VARCHAR(45) NULL,
  `IdStoreCustomerStore` INT NULL,
  PRIMARY KEY (`idStoreCustomers`),
  UNIQUE INDEX `StoreCustomersCellPhone_UNIQUE` (`StoreCustomersCellPhone` ASC) VISIBLE,
  UNIQUE INDEX `StoreCustomersEmail_UNIQUE` (`StoreCustomersEmail` ASC) VISIBLE,
  INDEX `fk_StoreCustomers_1_idx` (`IdStoreCustomerStore` ASC) VISIBLE,
  CONSTRAINT `fk_StoreCustomers_1`
    FOREIGN KEY (`IdStoreCustomerStore`)
    REFERENCES `InventoryStore`.`Stores` (`IdStore`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'store all customer by Store';


-- -----------------------------------------------------
-- Table `InventoryStore`.`StoreProducts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `InventoryStore`.`StoreProducts` ;

CREATE TABLE IF NOT EXISTS `InventoryStore`.`StoreProducts` (
  `IdStoreProduct` INT NOT NULL AUTO_INCREMENT COMMENT 'id autoincrement to use with entityframework',
  `StoreProductName` VARCHAR(45) NOT NULL,
  `StoreProductDescription` VARCHAR(45) NULL,
  `StoreProductCosto` DECIMAL(2) NOT NULL,
  `StoreProductPrecio` DECIMAL(2) NOT NULL,
  `StoreProductUnidadMedida` VARCHAR(45) NULL,
  `StoreProductNserie` VARCHAR(45) NULL,
  `StoreProductExpDate` DATETIME NULL,
  `StoreProductDateUp` DATETIME NULL,
  `StoreProductDateModify` DATETIME NULL,
  `StoreProductDeleted` TINYINT NULL,
  `IdStoreProductStore` INT NULL,
  PRIMARY KEY (`IdStoreProduct`),
  INDEX `fk_StoreProducts_1_idx` (`IdStoreProductStore` ASC) VISIBLE,
  CONSTRAINT `fk_StoreProducts_1`
    FOREIGN KEY (`IdStoreProductStore`)
    REFERENCES `InventoryStore`.`Stores` (`IdStore`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'This table contains detailed information aboun products, suchs a names, description etct.\n\na product can be bought or sold several times, therefore a many-to-many relationship is established between tables products and purchaes, products and sales ';


-- -----------------------------------------------------
-- Table `InventoryStore`.`StoreProvider`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `InventoryStore`.`StoreProvider` ;

CREATE TABLE IF NOT EXISTS `InventoryStore`.`StoreProvider` (
  `idStoreProvider` INT NOT NULL AUTO_INCREMENT,
  `StoreProviderRuc` VARCHAR(14) NULL,
  `StoreProviderName` VARCHAR(45) NULL,
  `StoreProviderAddress` VARCHAR(100) NULL,
  `StoreProviderTelefono` INT NULL,
  `StoreProviderEmail` VARCHAR(45) NULL,
  `StoreProviderDateUp` DATETIME NULL,
  `StoreProviderDateModify` DATETIME NULL,
  `StoreProviderDeleted` TINYINT NULL,
  `IdStoreProviderStore` INT NULL,
  PRIMARY KEY (`idStoreProvider`),
  INDEX `fk_StoreProvider_1_idx` (`IdStoreProviderStore` ASC) VISIBLE,
  CONSTRAINT `fk_StoreProvider_1`
    FOREIGN KEY (`IdStoreProviderStore`)
    REFERENCES `InventoryStore`.`Stores` (`IdStore`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'This table contains information about suppliers, such a name, address, phone, email etc.\n\nA provider can be several buy, therefor one-to-many relationship is established between StoreProvider and StoreSupplierPurchases.';


-- -----------------------------------------------------
-- Table `InventoryStore`.`StoreSupplierPurchases`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `InventoryStore`.`StoreSupplierPurchases` ;

CREATE TABLE IF NOT EXISTS `InventoryStore`.`StoreSupplierPurchases` (
  `IdStoreSupplierPurchases` INT NOT NULL AUTO_INCREMENT,
  `StoreSupplierPurchasesDate` DATETIME NOT NULL,
  `StoreSupplierPurchasesIdProvider` INT NULL COMMENT 'Foreign key to do relation width StoreProvider table',
  `StoreSupplierPurchasesQuantity` INT NULL,
  `StoreSupplierPurchasesPrice` DECIMAL(2) NULL,
  `StoreSupplierPurchasesDateUp` DATETIME NULL,
  `StoreSupplierPurchaseDateModiy` DATETIME NULL,
  `StoreSupplierPurchasesDeleted` TINYINT NULL,
  `IdStoreSupplierPurchasesStore` INT NULL,
  PRIMARY KEY (`IdStoreSupplierPurchases`),
  INDEX `fk_StoreSupplierPurchases_1_idx` (`StoreSupplierPurchasesIdProvider` ASC) VISIBLE,
  INDEX `fk_StoreSupplierPurchases_2_idx` (`IdStoreSupplierPurchasesStore` ASC) VISIBLE,
  CONSTRAINT `fk_StoreSupplierPurchases_1`
    FOREIGN KEY (`StoreSupplierPurchasesIdProvider`)
    REFERENCES `InventoryStore`.`StoreProvider` (`idStoreProvider`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_StoreSupplierPurchases_2`
    FOREIGN KEY (`IdStoreSupplierPurchasesStore`)
    REFERENCES `InventoryStore`.`Stores` (`IdStore`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'This table contains information about supplier purchases such a date, provideer, products purchases, quantity and prices';


-- -----------------------------------------------------
-- Table `InventoryStore`.`StorePaymentMethod`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `InventoryStore`.`StorePaymentMethod` ;

CREATE TABLE IF NOT EXISTS `InventoryStore`.`StorePaymentMethod` (
  `IdStorePaymentMethod` INT NOT NULL AUTO_INCREMENT,
  `StorePaymentMethodName` VARCHAR(45) NULL,
  `StorePaymentMethodDeleted` TINYINT NULL,
  `StorePaymentMethodDateUp` DATETIME NULL,
  `StorePaymentMethodDateModify` DATETIME NULL,
  `IdStorePaymentMethodStore` INT NULL,
  PRIMARY KEY (`IdStorePaymentMethod`),
  INDEX `fk_StorePaymentMethod_1_idx` (`IdStorePaymentMethodStore` ASC) VISIBLE,
  CONSTRAINT `fk_StorePaymentMethod_1`
    FOREIGN KEY (`IdStorePaymentMethodStore`)
    REFERENCES `InventoryStore`.`Stores` (`IdStore`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'this table is a one-to-many relationship with StoreSales\n\nThis table contains information about payments method as credit card, cash, paypal, etc';


-- -----------------------------------------------------
-- Table `InventoryStore`.`StoreSales`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `InventoryStore`.`StoreSales` ;

CREATE TABLE IF NOT EXISTS `InventoryStore`.`StoreSales` (
  `IdStoreSales` INT NOT NULL AUTO_INCREMENT COMMENT 'primary key to identified table witd detail sales table. this table contain all information about products.',
  `StoreSalesDate` DATETIME NULL,
  `IdStoreSalesCustomer` INT NULL,
  `StoreSalesQuantity` INT NULL,
  `StoreSalesPrice` DECIMAL(2) NULL,
  `StoreSalesDateUp` DATETIME NULL,
  `StoreSalesDateModify` DATETIME NULL,
  `StoreSalesDeleted` TINYINT NULL,
  `IdStoreSalesStore` INT NULL,
  `IdStoreSalesPayment` INT NULL,
  PRIMARY KEY (`IdStoreSales`),
  INDEX `fk_StoreSales_1_idx` (`IdStoreSalesCustomer` ASC) VISIBLE,
  INDEX `fk_StoreSales_3_idx` (`IdStoreSalesStore` ASC) VISIBLE,
  INDEX `fk_StoreSales_2_idx` (`IdStoreSalesPayment` ASC) VISIBLE,
  CONSTRAINT `fk_StoreSales_1`
    FOREIGN KEY (`IdStoreSalesCustomer`)
    REFERENCES `InventoryStore`.`StoreCustomers` (`idStoreCustomers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_StoreSales_2`
    FOREIGN KEY (`IdStoreSalesPayment`)
    REFERENCES `InventoryStore`.`StorePaymentMethod` (`IdStorePaymentMethod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_StoreSales_3`
    FOREIGN KEY (`IdStoreSalesStore`)
    REFERENCES `InventoryStore`.`Stores` (`IdStore`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'This table contains information about sell such date, customer, products, quantity and price';


-- -----------------------------------------------------
-- Table `mydb`.`StoreInventory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `InventoryStore`.`StoreInventory` ;

CREATE TABLE IF NOT EXISTS `InventoryStore`.`StoreInventory` (
  `IdStoreInventory` INT NOT NULL AUTO_INCREMENT,
  `StoreInventoryDate` DATETIME NULL,
  `StoreInventoryPrice` DECIMAL(2) NULL,
  `StoreInventoryDateUp` DATETIME NULL,
  `StoreInventoryDateModify` DATETIME NULL,
  `StoreInventoryDeleted` TINYINT NULL,
  `IdStoreInventoryStore` INT NOT NULL,
  PRIMARY KEY (`IdStoreInventory`),
  INDEX `fk_StoreInventory_1_idx` (`IdStoreInventoryStore` ASC) VISIBLE,
  CONSTRAINT `fk_StoreInventory_1`
    FOREIGN KEY (`IdStoreInventoryStore`)
    REFERENCES `InventoryStore`.`Stores` (`IdStore`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'This table contains information about current inventory such a date, products, quantity and price.\n\nan inventory is made up of several products and each product can have severa stock, therefore a many-to-many relationship is established between StoreInventory and StoreProducts\n';


-- -----------------------------------------------------
-- Table `mydb`.`StoreProductsCategory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `InventoryStore`.`StoreProductsCategory` ;

CREATE TABLE IF NOT EXISTS `InventoryStore`.`StoreProductsCategory` (
  `IdStoreProductsCategory` INT NOT NULL AUTO_INCREMENT,
  `StoreProductsCategoryName` VARCHAR(45) NULL,
  `StoreProductsCategoryDescription` VARCHAR(45) NULL,
  `StoreProductsCategoryDateUp` VARCHAR(45) NULL,
  `StoreProductsCategoryDateModify` VARCHAR(45) NULL,
  `StoreProductsCategoryDeleted` VARCHAR(45) NULL,
  `StoreProductsCategoryIdStore` INT NULL,
  PRIMARY KEY (`IdStoreProductsCategory`),
  INDEX `fk_StoreProductsCategory_1_idx` (`StoreProductsCategoryIdStore` ASC) VISIBLE,
  CONSTRAINT `fk_StoreProductsCategory_1`
    FOREIGN KEY (`StoreProductsCategoryIdStore`)
    REFERENCES `InventoryStore`.`Stores` (`IdStore`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `InventoryStore`.`StoreProductCategory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `InventoryStore`.`StoreProductCategory` ;

CREATE TABLE IF NOT EXISTS `InventoryStore`.`StoreProductCategory` (
  `IdStoreProductCategory` INT NOT NULL AUTO_INCREMENT,
  `IdStoreProductCategoryProd` INT NOT NULL,
  `IdStoreProductCategoryCat` INT NOT NULL,
  `StoreProductCategoryDateUp` DATETIME NULL,
  `StoreProductCategoryDateModify` DATETIME NULL,
  `StoreProductCategoryDeleted` TINYINT NULL,
  PRIMARY KEY (`IdStoreProductCategory`),
  INDEX `fk_StoreProductCategory_1_idx` (`IdStoreProductCategoryProd` ASC) VISIBLE,
  INDEX `fk_StoreProductCategory_2_idx` (`IdStoreProductCategoryCat` ASC) VISIBLE,
  CONSTRAINT `fk_StoreProductCategory_1`
    FOREIGN KEY (`IdStoreProductCategoryProd`)
    REFERENCES `InventoryStore`.`StoreProducts` (`IdStoreProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_StoreProductCategory_2`
    FOREIGN KEY (`IdStoreProductCategoryCat`)
    REFERENCES `InventoryStore`.`StoreProductsCategory` (`IdStoreProductsCategory`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `InventoryStore`.`StoreProductSales`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `InventoryStore`.`StoreProductSales` ;

CREATE TABLE IF NOT EXISTS `InventoryStore`.`StoreProductSales` (
  `IdStoreProductSales` INT NOT NULL AUTO_INCREMENT,
  `IdStoreProductSalesProduct` INT NOT NULL,
  `IdStoreProductSalesSales` INT NOT NULL,
  `StoreProductSalesQuantity` INT NULL,
  `StoreProductSalesPrice` DECIMAL(10,2) NULL,
  `StoreProductSalesTotal` DECIMAL(10,2) NULL COMMENT 'campo calculado, pero es mejor tener obtenr datos y no calcular muchos registros.',
  `StoreProductSalesDateUp` DATETIME NULL,
  `StoreProductSalesDateModify` DATETIME NULL,
  `StoreProductSalesDeleted` TINYINT NULL,
  PRIMARY KEY (`IdStoreProductSales`),
  INDEX `fk_StoreProductSales_1_idx` (`IdStoreProductSalesProduct` ASC) VISIBLE,
  INDEX `fk_StoreProductSales_2_idx` (`IdStoreProductSalesSales` ASC) VISIBLE,
  CONSTRAINT `fk_StoreProductSales_1`
    FOREIGN KEY (`IdStoreProductSalesProduct`)
    REFERENCES `InventoryStore`.`StoreProducts` (`IdStoreProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_StoreProductSales_2`
    FOREIGN KEY (`IdStoreProductSalesSales`)
    REFERENCES `InventoryStore`.`StoreSales` (`IdStoreSales`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `InventoryStore`.`StoreInventoryProduct`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `InventoryStore`.`StoreInventoryProduct` ;

CREATE TABLE IF NOT EXISTS `InventoryStore`.`StoreInventoryProduct` (
  `IdStoreInventoryProduct` INT NOT NULL AUTO_INCREMENT,
  `IdStoreInventoryProductProduct` INT NOT NULL,
  `IdStoreInventoryProductInventory` INT NOT NULL,
  `StoreInventoryProductSupplier` INT NULL,
  `StoreInventoryProductSales` INT NULL,
  `StoreInventoryProductQuantity` INT NULL,
  `StoreInventoryDateUp` DATETIME NULL,
  `StoreInventoryDateModify` DATETIME NULL,
  `StoreInventoryDeleted` TINYINT NULL,
  PRIMARY KEY (`IdStoreInventoryProduct`),
  INDEX `fk_StoreInventoryProduct_1_idx` (`IdStoreInventoryProductProduct` ASC) VISIBLE,
  INDEX `fk_StoreInventoryProduct_2_idx` (`IdStoreInventoryProductInventory` ASC) VISIBLE,
  CONSTRAINT `fk_StoreInventoryProduct_1`
    FOREIGN KEY (`IdStoreInventoryProductProduct`)
    REFERENCES `InventoryStore`.`StoreProducts` (`IdStoreProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_StoreInventoryProduct_2`
    FOREIGN KEY (`IdStoreInventoryProductInventory`)
    REFERENCES `InventoryStore`.`StoreInventory` (`IdStoreInventory`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`StorePrductsSupplier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `InventoryStore`.`StorePrductsSupplier` ;

CREATE TABLE IF NOT EXISTS `InventoryStore`.`StorePrductsSupplier` (
  `IdStorePrductsSupplier` INT NOT NULL AUTO_INCREMENT,
  `IdStorePrductsSupplierPurchases` INT NULL,
  `IdStorePrductsSupplierProduct` INT NULL,
  PRIMARY KEY (`IdStorePrductsSupplier`),
  INDEX `fk_StorePrductsSupplier_1_idx` (`IdStorePrductsSupplierPurchases` ASC) VISIBLE,
  INDEX `fk_StorePrductsSupplier_2_idx` (`IdStorePrductsSupplierProduct` ASC) VISIBLE,
  CONSTRAINT `fk_StorePrductsSupplier_1`
    FOREIGN KEY (`IdStorePrductsSupplierPurchases`)
    REFERENCES `InventoryStore`.`StoreSupplierPurchases` (`IdStoreSupplierPurchases`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_StorePrductsSupplier_2`
    FOREIGN KEY (`IdStorePrductsSupplierProduct`)
    REFERENCES `InventoryStore`.`StoreProducts` (`IdStoreProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
