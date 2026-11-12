Here is the complete data dictionary and glossary based on the provided SQL Server DDL file.

### Executive Overview

This document provides a comprehensive data dictionary and glossary for the International Baccalaureate (IB) School Data Vault. It includes inventories of all tables, columns, and relationships, along with documentation gaps and a summary of data profiling. The information is derived from the `IB_datavault 2.sql` DDL file.

### Table Inventory

| Schema | Table Name | Table Type | Business Description |
| :--- | :--- | :--- | :--- |
| Ib | HubStudent | Hub | Represents a unique student. |
| Ib | HubTeacher | Hub | Represents a unique teacher. |
| Ib | HubCourse | Hub | Represents a unique course. |
| Ib | HubCourseSection | Hub | Represents a unique section of a course. |
| Ib | HubSchool | Hub | Represents a unique school. |
| Ib | HubAcademicTerm | Hub | Represents a unique academic term. |
| Ib | HubProgramme | Hub | Represents a unique IB programme (e.g., PYP, MYP, DP, CP). |
| Ib | HubAssessment | Hub | Represents a unique assessment. |
| Ib | LnkSectionOffering | Link | Connects a course section with a course, academic term, and school. |
| Ib | LnkSectionTeacher | Link | Assigns a teacher to a course section with a specific role. |
| Ib | LnkStudentProgramme | Link | Associates a student with an IB programme at a school. |
| Ib | LnkEnrollment | Link | Represents a student's enrollment in a course section. |
| Ib | LnkAttendance | Link | Records a student's attendance for a specific course section, date, and period. |
| Ib | LnkAssessmentResult | Link | Stores the result of a student's assessment for a course section. |
| Ib | SatStudentPersonal | Satellite | Stores personal (PII) attributes of a student. |
| Ib | SatStudentAcademic | Satellite | Stores academic attributes of a student. |
| Ib | SatTeacherDetails | Satellite | Stores details about a teacher. |
| Ib | SatCourseDetails | Satellite | Stores details about a course. |
| Ib | SatCourseSectionDetails | Satellite | Stores details about a course section. |
| Ib | SatSchoolDetails | Satellite | Stores details about a school. |
| Ib | SatAcademicTermDetails | Satellite | Stores details about an academic term. |
| Ib | SatProgrammeDetails | Satellite | Stores details about an IB programme. |
| Ib | SatAssessmentDetails | Satellite | Stores details about an assessment. |
| Ib | SatEnrollmentDetails | Satellite | Stores details about a student's enrollment. |
| Ib | SatStudentProgrammeDetails | Satellite | Stores details about a student's programme. |
| Ib | SatAttendanceDetails | Satellite | Stores details about a student's attendance. |
| Ib | SatAssessmentResult | Satellite | Stores details about a student's assessment result. |
| Ib | RefAttendanceStatus | Reference | Reference table for attendance status codes. |
| Ib | BvSatAttendanceSummary | Business Vault | Computed satellite for attendance summary per enrollment. |

### Column Data Dictionary

**Table: HubStudent** (Hub)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
| :--- | :--- | :--- | :--- | :--- |
| StudentHk | Hash key for the student | binary(32) | PK, HK | |
| StudentBk | Business key for the student (school student ID) | varchar(50) | BK, UQ | |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: HubTeacher** (Hub)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
| :--- | :--- | :--- | :--- | :--- |
| TeacherHk | Hash key for the teacher | binary(32) | PK, HK | |
| TeacherBk | Business key for the teacher (staff ID) | varchar(50) | BK, UQ | |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: HubCourse** (Hub)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
| :--- | :--- | :--- | :--- | :--- |
| CourseHk | Hash key for the course | binary(32) | PK, HK | |
| CourseBk | Business key for the course (e.g. MATH-AA-HL) | varchar(50) | BK, UQ | |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: HubCourseSection** (Hub)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
| :--- | :--- | :--- | :--- | :--- |
| CourseSectionHk | Hash key for the course section | binary(32) | PK, HK | |
| CourseSectionBk | Business key for the course section (SchoolCode||TermCode||CourseCode||SectionCode) | varchar(120) | BK, UQ | |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: HubSchool** (Hub)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
| :--- | :--- | :--- | :--- | :--- |
| SchoolHk | Hash key for the school | binary(32) | PK, HK | |
| SchoolBk | Business key for the school (IB school code) | varchar(20) | BK, UQ | |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: HubAcademicTerm** (Hub)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
| :--- | :--- | :--- | :--- | :--- |
| AcademicTermHk | Hash key for the academic term | binary(32) | PK, HK | |
| AcademicTermBk | Business key for the academic term (e.g. 2025-FALL) | varchar(30) | BK, UQ | |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: HubProgramme** (Hub)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
| :--- | :--- | :--- | :--- | :--- |
| ProgrammeHk | Hash key for the programme | binary(32) | PK, HK | |
| ProgrammeBk | Business key for the programme (PYP, MYP, DP, CP) | varchar(10) | BK, UQ | |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: HubAssessment** (Hub)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
| :--- | :--- | :--- | :--- | :--- |
| AssessmentHk | Hash key for the assessment | binary(32) | PK, HK | |
| AssessmentBk | Business key for the assessment (e.g. MATH-AA-HL-IA, EE, TOK-ESSAY, CAS) | varchar(60) | BK, UQ | |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: LnkSectionOffering** (Link)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
| :--- | :--- | :--- | :--- | :--- |
| SectionOfferingHk | Hash key for the section offering | binary(32) | PK, HK | |
| CourseSectionHk | Foreign key to HubCourseSection | binary(32) | FK | HubCourseSection |
| CourseHk | Foreign key to HubCourse | binary(32) | FK | HubCourse |
| AcademicTermHk | Foreign key to HubAcademicTerm | binary(32) | FK | HubAcademicTerm |
| SchoolHk | Foreign key to HubSchool | binary(32) | FK | HubSchool |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: LnkSectionTeacher** (Link)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
| :--- | :--- | :--- | :--- | :--- |
| SectionTeacherHk | Hash key for the section teacher | binary(32) | PK, HK | |
| CourseSectionHk | Foreign key to HubCourseSection | binary(32) | FK | HubCourseSection |
| TeacherHk | Foreign key to HubTeacher | binary(32) | FK | HubTeacher |
| TeacherRole | Role of the teacher (PRIMARY, CO-TEACHER, SUBSTITUTE) | varchar(20) | | |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: LnkStudentProgramme** (Link)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
| :--- | :--- | :--- | :--- | :--- |
| StudentProgrammeHk | Hash key for the student programme | binary(32) | PK, HK | |
| StudentHk | Foreign key to HubStudent | binary(32) | FK | HubStudent |
| ProgrammeHk | Foreign key to HubProgramme | binary(32) | FK | HubProgramme |
| SchoolHk | Foreign key to HubSchool | binary(32) | FK | HubSchool |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: LnkEnrollment** (Link)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
| :--- | :--- | :--- | :--- | :--- |
| EnrollmentHk | Hash key for the enrollment | binary(32) | PK, HK | |
| StudentHk | Foreign key to HubStudent | binary(32) | FK | HubStudent |
| CourseSectionHk | Foreign key to HubCourseSection | binary(32) | FK | HubCourseSection |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: LnkAttendance** (Link)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
| :--- | :--- | :--- | :--- | :--- |
| AttendanceHk | Hash key for the attendance | binary(32) | PK, HK | |
| StudentHk | Foreign key to HubStudent | binary(32) | FK | HubStudent |
| CourseSectionHk | Foreign key to HubCourseSection | binary(32) | FK | HubCourseSection |
| AttendanceDate | Date of attendance | date | | |
| PeriodNumber | Period number | tinyint | | |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: LnkAssessmentResult** (Link)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
| :--- | :--- | :--- | :--- | :--- |
| AssessmentResultHk | Hash key for the assessment result | binary(32) | PK, HK | |
| StudentHk | Foreign key to HubStudent | binary(32) | FK | HubStudent |
| AssessmentHk | Foreign key to HubAssessment | binary(32) | FK | HubAssessment |
| CourseSectionHk | Foreign key to HubCourseSection | binary(32) | FK | HubCourseSection |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: SatStudentPersonal** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
| :--- | :--- | :--- | :--- | :--- |
| StudentHk | Foreign key to HubStudent | binary(32) | PK, FK | HubStudent |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference | binary(32) | Metadata | |
| FirstName | First name of the student | varchar(100) | | |
| MiddleName | Middle name of the student | varchar(100) | | |
| LastName | Last name of the student | varchar(100) | | |
| PreferredName | Preferred name of the student | varchar(100) | | |
| BirthDate | Birth date of the student | date | | |
| Gender | Gender of the student | char(1) | | |
| Nationality | Nationality of the student (ISO 3166-1 alpha-2) | varchar(2) | | |
| NativeLanguage | Native language of the student | varchar(50) | | |
| Email | Email of the student | varchar(255) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: SatStudentAcademic** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
| :--- | :--- | :--- | :--- | :--- |
| StudentHk | Foreign key to HubStudent | binary(32) | PK, FK | HubStudent |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference | binary(32) | Metadata | |
| GradeLevel | Grade level of the student (e.g. Grade 11 / Year 12) | varchar(10) | | |
| IbCandidateCode | IB candidate (personal) code | varchar(20) | | |
| EnrollmentStatus | Enrollment status of the student (Active, Withdrawn, Graduated) | varchar(20) | | |
| AdmissionDate | Admission date of the student | date | | |
| HouseOrHomeroom | House or homeroom of the student | varchar(30) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: SatTeacherDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
| :--- | :--- | :--- | :--- | :--- |
| TeacherHk | Foreign key to HubTeacher | binary(32) | PK, FK | HubTeacher |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference | binary(32) | Metadata | |
| FirstName | First name of the teacher | varchar(100) | | |
| LastName | Last name of the teacher | varchar(100) | | |
| Email | Email of the teacher | varchar(255) | | |
| Department | Department of the teacher | varchar(100) | | |
| IbWorkshopCertified | IB workshop certified status of the teacher | bit | | |
| IsActive | Active status of the teacher | bit | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: SatCourseDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
| :--- | :--- | :--- | :--- | :--- |
| CourseHk | Foreign key to HubCourse | binary(32) | PK, FK | HubCourse |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference | binary(32) | Metadata | |
| CourseName | Name of the course | varchar(200) | | |
| ProgrammeCode | Programme code (PYP, MYP, DP, CP) | varchar(10) | | |
| SubjectGroup | DP subject group (1-6) | tinyint | | |
| SubjectArea | Subject area of the course | varchar(100) | | |
| CourseLevel | Course level (HL, SL, Standard) | varchar(10) | | |
| LanguageOfInstruction | Language of instruction | varchar(50) | | |
| TeachingHours | Teaching hours (240 HL / 150 SL) | smallint | | |
| IsCore | Core status of the course (TOK, EE, CAS) | bit | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: SatCourseSectionDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
| :--- | :--- | :--- | :--- | :--- |
| CourseSectionHk | Foreign key to HubCourseSection | binary(32) | PK, FK | HubCourseSection |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference | binary(32) | Metadata | |
| SectionCode | Section code | varchar(20) | | |
| Room | Room of the section | varchar(30) | | |
| SchedulePeriod | Schedule period of the section | varchar(30) | | |
| Capacity | Capacity of the section | smallint | | |
| SectionStatus | Status of the section | varchar(20) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: SatSchoolDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
| :--- | :--- | :--- | :--- | :--- |
| SchoolHk | Foreign key to HubSchool | binary(32) | PK, FK | HubSchool |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference | binary(32) | Metadata | |
| SchoolName | Name of the school | varchar(200) | | |
| CountryCode | Country code of the school | varchar(2) | | |
| City | City of the school | varchar(100) | | |
| TimeZone | Time zone of the school | varchar(50) | | |
| AuthorizedProgrammes | Authorized programmes of the school (e.g. PYP,MYP,DP) | varchar(50) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: SatAcademicTermDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
| :--- | :--- | :--- | :--- | :--- |
| AcademicTermHk | Foreign key to HubAcademicTerm | binary(32) | PK, FK | HubAcademicTerm |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference | binary(32) | Metadata | |
| TermName | Name of the term | varchar(50) | | |
| AcademicYear | Academic year (2025-2026) | varchar(9) | | |
| StartDate | Start date of the term | date | | |
| EndDate | End date of the term | date | | |
| InstructionalDays | Instructional days in the term | smallint | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: SatProgrammeDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
| :--- | :--- | :--- | :--- | :--- |
| ProgrammeHk | Foreign key to HubProgramme | binary(32) | PK, FK | HubProgramme |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference | binary(32) | Metadata | |
| ProgrammeName | Name of the programme | varchar(100) | | |
| AgeRange | Age range of the programme (3-12, 11-16, 16-19) | varchar(20) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: SatAssessmentDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
| :--- | :--- | :--- | :--- | :--- |
| AssessmentHk | Foreign key to HubAssessment | binary(32) | PK, FK | HubAssessment |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference | binary(32) | Metadata | |
| AssessmentName | Name of the assessment | varchar(200) | | |
| AssessmentType | Type of the assessment (IA, EE, TOK, CAS, EXAM, INTERNAL) | varchar(20) | | |
| IsInternal | Internal status of the assessment | bit | | |
| MaxScore | Maximum score of the assessment | decimal(8,2) | | |
| WeightPercent | Weight percent of the assessment | decimal(5,2) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: SatEnrollmentDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
| :--- | :--- | :--- | :--- | :--- |
| EnrollmentHk | Foreign key to LnkEnrollment | binary(32) | PK, FK | LnkEnrollment |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference | binary(32) | Metadata | |
| EnrollmentStatus | Enrollment status (Enrolled, Dropped, Completed) | varchar(20) | | |
| CourseLevel | Course level chosen by the student (HL / SL) | varchar(10) | | |
| EnrollDate | Enrollment date | date | | |
| DropDate | Drop date | date | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: SatStudentProgrammeDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
| :--- | :--- | :--- | :--- | :--- |
| StudentProgrammeHk | Foreign key to LnkStudentProgramme | binary(32) | PK, FK | LnkStudentProgramme |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference | binary(32) | Metadata | |
| CandidateType | Candidate type (Diploma, Course candidate) | varchar(30) | | |
| StartDate | Start date of the programme | date | | |
| ExpectedGraduationDate | Expected graduation date | date | | |
| ProgrammeStatus | Status of the programme | varchar(20) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: SatAttendanceDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
| :--- | :--- | :--- | :--- | :--- |
| AttendanceHk | Foreign key to LnkAttendance | binary(32) | PK, FK | LnkAttendance |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference | binary(32) | Metadata | |
| AttendanceStatusCode | Attendance status code (P, A, L, E) | varchar(10) | | |
| MinutesLate | Minutes late | smallint | | |
| AbsenceReason | Reason for absence | varchar(200) | | |
| RecordedBy | Person who recorded the attendance | varchar(100) | | |
| RecordedDts | Date/time stamp of recording | datetime2(7) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: SatAssessmentResult** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
| :--- | :--- | :--- | :--- | :--- |
| AssessmentResultHk | Foreign key to LnkAssessmentResult | binary(32) | PK, FK | LnkAssessmentResult |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference | binary(32) | Metadata | |
| RawScore | Raw score of the assessment | decimal(8,2) | | |
| IbGrade | IB grade (1-7) | tinyint | | |
| PredictedGrade | Predicted grade (1-7) | tinyint | | |
| ResultType | Type of the result (Predicted, Internal, Moderated, Final) | varchar(20) | | |
| AssessedDate | Date of assessment | date | | |
| AssessedBy | Person who assessed | varchar(100) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: RefAttendanceStatus** (Reference)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
| :--- | :--- | :--- | :--- | :--- |
| AttendanceStatusCode | Attendance status code | varchar(10) | PK | |
| StatusName | Name of the status | varchar(50) | | |
| IsPresent | Present status | bit | | |
| IsExcused | Excused status | bit | | |

**Table: BvSatAttendanceSummary** (Business Vault)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
| :--- | :--- | :--- | :--- | :--- |
| EnrollmentHk | Foreign key to LnkEnrollment | binary(32) | PK, FK | LnkEnrollment |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| DaysPresent | Number of days present | int | | |
| DaysLate | Number of days late | int | | |
| DaysAbsentExcused | Number of days absent (excused) | int | | |
| DaysAbsentUnexcused | Number of days absent (unexcused) | int | | |
| AttendancePercent | Attendance percentage | decimal(5,2) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

### Relationship Inventory

| Table Name | Column Name | Relationship Type | Referenced Table Name | Referenced Column Name |
| :--- | :--- | :--- | :--- | :--- |
| LnkSectionOffering | CourseSectionHk | FOREIGN KEY | HubCourseSection | CourseSectionHk |
| LnkSectionOffering | CourseHk | FOREIGN KEY | HubCourse | CourseHk |
| LnkSectionOffering | AcademicTermHk | FOREIGN KEY | HubAcademicTerm | AcademicTermHk |
| LnkSectionOffering | SchoolHk | FOREIGN KEY | HubSchool | SchoolHk |
| LnkSectionTeacher | CourseSectionHk | FOREIGN KEY | HubCourseSection | CourseSectionHk |
| LnkSectionTeacher | TeacherHk | FOREIGN KEY | HubTeacher | TeacherHk |
| LnkStudentProgramme | StudentHk | FOREIGN KEY | HubStudent | StudentHk |
| LnkStudentProgramme | ProgrammeHk | FOREIGN KEY | HubProgramme | ProgrammeHk |
| LnkStudentProgramme | SchoolHk | FOREIGN KEY | HubSchool | SchoolHk |
| LnkEnrollment | StudentHk | FOREIGN KEY | HubStudent | StudentHk |
| LnkEnrollment | CourseSectionHk | FOREIGN KEY | HubCourseSection | CourseSectionHk |
| LnkAttendance | StudentHk | FOREIGN KEY | HubStudent | StudentHk |
| LnkAttendance | CourseSectionHk | FOREIGN KEY | HubCourseSection | CourseSectionHk |
| LnkAssessmentResult | StudentHk | FOREIGN KEY | HubStudent | StudentHk |
| LnkAssessmentResult | AssessmentHk | FOREIGN KEY | HubAssessment | AssessmentHk |
| LnkAssessmentResult | CourseSectionHk | FOREIGN KEY | HubCourseSection | CourseSectionHk |
| SatStudentPersonal | StudentHk | FOREIGN KEY | HubStudent | StudentHk |
| SatStudentAcademic | StudentHk | FOREIGN KEY | HubStudent | StudentHk |
| SatTeacherDetails | TeacherHk | FOREIGN KEY | HubTeacher | TeacherHk |
| SatCourseDetails | CourseHk | FOREIGN KEY | HubCourse | CourseHk |
| SatCourseSectionDetails | CourseSectionHk | FOREIGN KEY | HubCourseSection | CourseSectionHk |
| SatSchoolDetails | SchoolHk | FOREIGN KEY | HubSchool | SchoolHk |
| SatAcademicTermDetails | AcademicTermHk | FOREIGN KEY | HubAcademicTerm | AcademicTermHk |
| SatProgrammeDetails | ProgrammeHk | FOREIGN KEY | HubProgramme | ProgrammeHk |
| SatAssessmentDetails | AssessmentHk | FOREIGN KEY | HubAssessment | AssessmentHk |
| SatEnrollmentDetails | EnrollmentHk | FOREIGN KEY | LnkEnrollment | EnrollmentHk |
| SatStudentProgrammeDetails | StudentProgrammeHk | FOREIGN KEY | LnkStudentProgramme | StudentProgrammeHk |
| SatAttendanceDetails | AttendanceHk | FOREIGN KEY | LnkAttendance | AttendanceHk |
| SatAssessmentResult | AssessmentResultHk | FOREIGN KEY | LnkAssessmentResult | AssessmentResultHk |
| BvSatAttendanceSummary | EnrollmentHk | FOREIGN KEY | LnkEnrollment | EnrollmentHk |

### Documentation Gaps

*   **Business Descriptions:** Many column descriptions are derived from their names. Formal business definitions should be gathered from subject matter experts. For example, the exact meaning of `IbCandidateCode` in `SatStudentAcademic` or the various `...Bk` (business key) columns should be explicitly defined.
*   **Unclear Terminology:** The meaning of some enumerated values is not fully defined. For example, the valid values for `TeacherRole` in `LnkSectionTeacher` are listed as 'PRIMARY, CO-TEACHER, SUBSTITUTE', but their specific responsibilities are not described. Similarly, for `EnrollmentStatus` in `SatStudentAcademic` and `SatEnrollmentDetails`, and `ResultType` in `SatAssessmentResult`.
*   **Missing Business Rules:** The DDL provides the structure, but not the business rules that govern the data. For example, what are the constraints on a student's enrollment in a programme or course?

### Data Profiling Summary

The data profiling report (`IB_Data_Profile_Report_Template_Style (2).pdf`) was not in a readable format for this agent. Therefore, no data profiling results can be included in this documentation. It is recommended to provide the profiling results in a structured text format (e.g., CSV, JSON, or a readable text file) for future analysis and inclusion in this glossary.

A comprehensive data profiling exercise should be executed to:
*   Verify the uniqueness and format of business keys.
*   Assess the completeness and quality of all columns, especially those marked as nullable.
*   Analyze the distribution of values in key categorical columns (e.g., `GradeLevel`, `EnrollmentStatus`, `ProgrammeCode`).
*   Validate that foreign key relationships are maintained.
*   Check for any inconsistencies or anomalies in the data.

Once the profiling is complete, the results should be integrated into this document to provide a more complete picture of the data.
