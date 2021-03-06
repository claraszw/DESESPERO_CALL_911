CREATE TABLE aluno
(
	matricula	numeric(7)	NOT NULL,
	
	Constraint pk_aluno Primary Key (matricula),
	
	nome		varchar(50)	NOT NULL

);

CREATE TABLE grad
(
	matricula numeric(7)	NOT NULL,
	
	Constraint fk_graduacao Foreign Key (matricula)
	References aluno (matricula),
	
	curso 	  varchar(30)	NOT NULL

);

CREATE TABLE posgrad
(
	matricula numeric(7)	NOT NULL,
	
	Constraint fk_posgrad_matricula Foreign Key (matricula)
	References aluno (matricula),
	CONSTRAINT pk_posgrad Primary Key (matricula),
	
	tipo	  varchar(9)	NOT NULL,
	
	Constraint CKC_tipo_posgrad
	Check (tipo IN ('doutorado','mestrado')),
	
	area	  varchar(50)	NOT NULL,
	situacao  varchar(10)	NOT NULL,
	
	Constraint CKC_situacao_posgrad
	Check (situacao IN ('afastou-se','em curso','atrasado','formando','formado')),
	
	CPF		  char(14)	NOT NULL,
	
	CONSTRAINT CKC_cpf CHECK (cpf like ('___.___.___-__')),
	CONSTRAINT UNI_cpf UNIQUE (cpf),
	
	anotacao  varchar(200)	,
	email 	  varchar(30)	NOT NULL,
	
	Constraint CKC_email 
	CHECK (email like ('%@inf.puc-rio.br')),
	
	login	  varchar(20)	NOT NULL,
	
	CONSTRAINT UNI_login UNIQUE (login),
	
	lattes	  varchar(50)	NOT NULL,
	
	CONSTRAINT CKC_lattes CHECK (lattes like ('http://lattes.cnpq.br/%')),
	CONSTRAINT UNI_lattes UNIQUE (lattes),
	
	periodoinicio   numeric(5,1)    NOT NULL,
	estimativa 	    numeric(5,1)	NOT NULL,
	status_matricula varchar(12)    NOT NULL,
	
	Constraint CKC_status_posgrad
	Check (status_matricula IN ('prorrogação','marcou banca','matriculado',
	'reabrindo','afastou-se','trancamento','formado')),
	
	data_nascimento	 date		    NOT NULL,
	sexo	  char(1)		NOT NULL,
	
	Constraint CKC_sexo_posgrad
	Check (sexo IN ('F','H')),
	
	pais_nascimento varchar(20),		
	estado_origem	varchar(30),
	nacionalidade	varchar(30)		NOT NULL,
	naturalidade	varchar(30)		NOT NULL,
	id				varchar(10),
	orgao_emissor	varchar(30),
	data_emissao	date,
	num_passaporte  varchar(20),
	pais_passaporte	varchar(30),	
	validade_passaporte date,
	logradouro		varchar(30)		NOT NULL,
	cidade			varchar(30)		NOT NULL,
	estado			varchar(30)		NOT NULL,
	cep				numeric(8)		NOT NULL,
	telefone		numeric(11),
	celular			numeric(11),
	num_banco		char(4)			NOT NULL,
	num_conta		numeric(8)		NOT NULL,
	num_agencia		numeric(4)		NOT NULL,
	nome_agencia	varchar(30)		NOT NULL,
	dedicacao		varchar(9)		NOT NULL,
	
	Constraint CKC_dedicacao_posgrad
	Check (dedicacao IN ('parcial','exclusiva')),
	
	orientador		numeric(7),
	
	Constraint fk_posgrad_orientador Foreign Key (orientador)
	References professor (matricula),
	
	coorientador	numeric(7),
	
	Constraint fk_posgrad_coorientador Foreign Key (coorientador)
	References professor (matricula)
	
);


CREATE TABLE professor
(
	matricula	numeric(7)	NOT NULL,
	
	Constraint pk_professor Primary Key (matricula),
	
	nome		varchar(50)	NOT NULL,
	nome_lab	varchar(50),
	

	data_ini_membro date	,
	data_fim_membro date
	
);
ALTER TABLE professor ADD 	Constraint fk_professor_nome_lab Foreign Key (nome_lab)
	References laboratorio (nome);
	
	
CREATE TABLE disciplina
(
	codigo 	char(7)	NOT NULL,
	
	Constraint pk_disciplina Primary Key (codigo),
	
	nome	varchar(50)	NOT NULL
	
);

CREATE TABLE laboratorio
(
	nome	varchar(50)	NOT NULL,
	
	Constraint pk_laboratorio Primary Key (nome),
	
	area 	varchar(50)	NOT NULL,
	responsavel numeric(7)	NOT NULL,
	
	Constraint fk_laboratorio_responsavel Foreign Key (responsavel)
	References professor (matricula)
	
);

CREATE TABLE bolsa
(
	tipo	varchar(50)	NOT NULL,
	
	aluno   numeric(7)	NOT NULL,
	
	Constraint fk_bolsa_aluno Foreign Key (aluno)
	References aluno (matricula),
	
	data_ini date	NOT NULL,
	
	Constraint pk_bolsa Primary Key (aluno,tipo,data_ini),
	
	data_fim date 	
	
);

CREATE TABLE monitoria
(
	aluno   numeric(7)	NOT NULL,
	
	Constraint fk_monitoria_aluno Foreign Key (aluno)
	References aluno (matricula),
	
	codigo 	char(7)	NOT NULL,
	
	Constraint fk_monitoria_codigo Foreign Key (codigo)
	References disciplina (codigo),
	
	data_ini date	NOT NULL,
	
	Constraint pk_monitoria Primary Key (codigo,aluno,data_ini),
	
	data_fim date 	
	
);

CREATE TABLE estagiolab
(
	aluno   numeric(7)	NOT NULL,
	
	Constraint fk_estagiolab_aluno Foreign Key (aluno)
	References aluno (matricula),
	
	laboratorio	varchar(50)	NOT NULL,
	
	Constraint fk_estagiolab_laboratorio Foreign Key (laboratorio)
	References laboratorio (nome),
	
	data_ini date	NOT NULL,
	
	Constraint pk_estagiolab Primary Key (laboratorio,aluno,data_ini),
	
	data_fim date 	
);

CREATE TABLE projetoorientado
(
	aluno   numeric(7)	NOT NULL,
	
	Constraint fk_projeto_orientado_aluno Foreign Key (aluno)
	References aluno (matricula),
	
	codigo	char(7)		NOT NULL,
	
	Constraint pk_projeto_orientado Primary Key (codigo,aluno),
	
	tema varchar(50)	NOT NULL,
	numcred	numeric(2)	NOT NULL,
	nota	numeric(3,1) NOT NULL,
	periodo numeric(5,1)    NOT NULL,
	matricula_prof numeric(7) NOT NULL,
	
	Constraint fk_projeto_orientado_matricula_prof Foreign Key (matricula_prof)
	References professor (matricula)
	
);