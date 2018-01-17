-- Create schemas

-- Create tables
IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'paciente'))
BEGIN
  CREATE TABLE paciente
  (
    codpaciente INT NOT NULL,
    appat VARCHAR(100),
    apmat VARCHAR(100),
    nombres VARCHAR(100),
    dni VARCHAR(8),
    sexo BOOLEAN,
    telfijo VARCHAR(7),
    telcelular VARCHAR(9),
    teltrabajo VARCHAR(9),
    domicilio VARCHAR(200),
    email VARCHAR(100),
    fecnac DATE,
    fecreg DATE,
    resppago VARCHAR(200),
    razonsocial VARCHAR(100),
    telcontacto VARCHAR(9),
    PRIMARY KEY(codpaciente)
  )
END;

IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'antecedente'))
BEGIN
  CREATE TABLE antecedente
  (
    codantecedente INT NOT NULL,
    cododonto INT,
    alergmed BOOLEAN,
    descam VARCHAR(300),
    prophemo BOOLEAN,
    complanest BOOLEAN,
    enfermactual BOOLEAN,
    descea VARCHAR(300),
    presarterial BOOLEAN,
    descpa VARCHAR(300),
    obs VARCHAR(400),
    PRIMARY KEY(codantecedente)
  )
END;

IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'enfermedadperiodontal'))
BEGIN
  CREATE TABLE enfermedadperiodontal
  (
    codeperiodontal INT NOT NULL,
    cododonto INT,
    placabact BOOLEAN,
    calsuprag BOOLEAN,
    calsubg BOOLEAN,
    bolsaperio BOOLEAN,
    movdental BOOLEAN,
    obs VARCHAR(400),
    PRIMARY KEY(codeperiodontal)
  )
END;

IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'oclusion'))
BEGIN
  CREATE TABLE oclusion
  (
    codoclusion INT NOT NULL,
    cododonto INT,
    malocldent BOOLEAN,
    maloclmax BOOLEAN,
    obs VARCHAR(400),
    PRIMARY KEY(codoclusion)
  )
END;

IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'odontograma'))
BEGIN
  CREATE TABLE odontograma
  (
    cododonto INT NOT NULL,
    codpaciente INT,
    fecha DATE,
    PRIMARY KEY(cododonto)
  )
END;

IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'pregunta'))
BEGIN
  CREATE TABLE pregunta
  (
    codpreg INT NOT NULL,
    cododonto INT,
    cardiaco BOOLEAN,
    cardiacoobs VARCHAR(400),
    famenferm BOOLEAN,
    famenfermobs VARCHAR(400),
    accfisico BOOLEAN,
    accfisico VARCHAR(400),
    apamplia BOOLEAN,
    rechina BOOLEAN,
    endodoncia BOOLEAN,
    endodonciaobs VARCHAR(400),
    obs VARCHAR(400),
    PRIMARY KEY(codpreg)
  )
END;

IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'tratamiento'))
BEGIN
  CREATE TABLE tratamiento
  (
    codtrat INT NOT NULL,
    codplantrat INT,
    fecha DATE,
    pieza VARCHAR(100),
    trat VARCHAR(400),
    res VARCHAR(100),
    proced VARCHAR(400),
    costo DECIMAL(7, 2),
    saldo DECIMAL(7, 2),
    estadopago BOOLEAN,
    PRIMARY KEY(codtrat)
  )
END;

IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'plandetratamiento'))
BEGIN
  CREATE TABLE plandetratamiento
  (
    codplantrat INT NOT NULL,
    codpaciente INT,
    q INT,
    trat VARCHAR(600),
    costo DECIMAL(7, 2),
    total DECIMAL(7, 2),
    fechainicio DATE,
    fechafin DATE,
    estadoplan BOOLEAN,
    PRIMARY KEY(codplantrat)
  )
END;

IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'pago'))
BEGIN
  CREATE TABLE pago
  (
    codpago INT NOT NULL,
    codtrat INT,
    fecha DATE,
    concepto VARCHAR(400),
    pagocuenta DECIMAL(7, 2),
    PRIMARY KEY(codpago)
  )
END;

IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'cita'))
BEGIN
  CREATE TABLE cita
  (
    codcita INT NOT NULL,
    codpaciente INT,
    fecha DATE,
    horainicio TIME,
    horafinal TIME,
    obs VARCHAR(400),
    PRIMARY KEY(codcita)
  )
END;


-- Create FKs
ALTER TABLE odontograma
    ADD    FOREIGN KEY (codpaciente)
    REFERENCES paciente(codpaciente)
;
    
ALTER TABLE oclusion
    ADD    FOREIGN KEY (cododonto)
    REFERENCES odontograma(cododonto)
;
    
ALTER TABLE enfermedadperiodontal
    ADD    FOREIGN KEY (cododonto)
    REFERENCES odontograma(cododonto)
;
    
ALTER TABLE antecedente
    ADD    FOREIGN KEY (cododonto)
    REFERENCES odontograma(cododonto)
;
    
ALTER TABLE pregunta
    ADD    FOREIGN KEY (cododonto)
    REFERENCES odontograma(cododonto)
;
    
ALTER TABLE plandetratamiento
    ADD    FOREIGN KEY (codpaciente)
    REFERENCES paciente(codpaciente)
;
    
ALTER TABLE tratamiento
    ADD    FOREIGN KEY (codplantrat)
    REFERENCES plandetratamiento(codplantrat)
;
    
ALTER TABLE pago
    ADD    FOREIGN KEY (codtrat)
    REFERENCES tratamiento(codtrat)
;
    
ALTER TABLE cita
    ADD    FOREIGN KEY (codpaciente)
    REFERENCES paciente(codpaciente)
;
    

-- Create Indexes

