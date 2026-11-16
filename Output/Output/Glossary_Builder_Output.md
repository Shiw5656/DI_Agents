### Executive Overview

This document provides a complete data dictionary and glossary for the International Baccalaureate (IB) school Data Vault model. The model integrates data across several core academic domains: Student, Course, Section, Enrollment, Attendance, and Assessment. It is designed to provide a consistent, traceable, and historically maintained view of academic activities, enabling institutions to monitor student participation, academic performance, attendance patterns, and programme delivery. All tables and columns are documented, and relationships are inventoried.

### Table Inventory

| Schema | Table Name | Table Type | Business Description |
|---|---|---|---|
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
| Ib | LnkStudentProgramme | Link | Connects a student to an IB programme at a school. |
| Ib | LnkEnrollment | Link | Represents a student's enrollment in a course section. |
| Ib | LnkAttendance | Link | Records a student's attendance for a specific course section on a given date and period. |
| Ib | LnkAssessmentResult | Link | Records a student's result for an assessment in a course section. |
| Ib | SatStudentPersonal | Satellite | Contains personal and PII attributes of a student. |
| Ib | SatStudentAcademic | Satellite | Contains academic attributes of a student. |
| Ib | SatTeacherDetails | Satellite | Contains attributes of a teacher. |
| Ib | SatCourseDetails | Satellite | Contains attributes of a course. |
| Ib | SatCourseSectionDetails | Satellite | Contains attributes of a course section. |
| Ib | SatSchoolDetails | Satellite | Contains attributes of a school. |
| Ib | SatAcademicTermDetails | Satellite | Contains attributes of an academic term. |
| Ib | SatProgrammeDetails | Satellite | Contains attributes of an IB programme. |
| Ib | SatAssessmentDetails | Satellite | Contains attributes of an assessment. |
| Ib | SatEnrollmentDetails | Satellite | Contains attributes of a student's enrollment in a course section. |
| Ib | SatStudentProgrammeDetails | Satellite | Contains attributes of a student's participation in an IB programme. |
| Ib | SatAttendanceDetails | Satellite | Contains attributes of a student's attendance. |
| Ib | SatAssessmentResult | Satellite | Contains attributes of a student's assessment result. |
| Ib | RefAttendanceStatus | Reference | A reference table for attendance status codes. |
| Ib | BvSatAttendanceSummary | Business Vault | A computed satellite that summarizes attendance per enrollment. |

### Column Data Dictionary

**Table: HubStudent** (Hub)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| StudentHk | Hash key for the student | binary(32) | PK, HK | |
| StudentBk | Business key for the student (school student ID) | varchar(50) | BK, UQ | |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: HubTeacher** (Hub)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| TeacherHk | Hash key for the teacher | binary(32) | PK, HK | |
| TeacherBk | Business key for the teacher (staff ID) | varchar(50) | BK, UQ | |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: HubCourse** (Hub)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| CourseHk | Hash key for the course | binary(32) | PK, HK | |
| CourseBk | Business key for the course (e.g. MATH-AA-HL) | varchar(50) | BK, UQ | |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: HubCourseSection** (Hub)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| CourseSectionHk | Hash key for the course section | binary(32) | PK, HK | |
| CourseSectionBk | Business key for the course section (SchoolCode||TermCode||CourseCode||SectionCode) | varchar(120) | BK, UQ | |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: HubSchool** (Hub)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| SchoolHk | Hash key for the school | binary(32) | PK, HK | |
| SchoolBk | Business key for the school (IB school code) | varchar(20) | BK, UQ | |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: HubAcademicTerm** (Hub)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| AcademicTermHk | Hash key for the academic term | binary(32) | PK, HK | |
| AcademicTermBk | Business key for the academic term (e.g. 2025-FALL) | varchar(30) | BK, UQ | |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: HubProgramme** (Hub)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| ProgrammeHk | Hash key for the programme | binary(32) | PK, HK | |
| ProgrammeBk | Business key for the programme (PYP, MYP, DP, CP) | varchar(10) | BK, UQ | |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: HubAssessment** (Hub)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| AssessmentHk | Hash key for the assessment | binary(32) | PK, HK | |
| AssessmentBk | Business key for the assessment (e.g. MATH-AA-HL-IA, EE, TOK-ESSAY, CAS) | varchar(60) | BK, UQ | |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: LnkSectionOffering** (Link)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| SectionOfferingHk | Hash key for the section offering link | binary(32) | PK, HK | |
| CourseSectionHk | Foreign key to HubCourseSection | binary(32) | FK | HubCourseSection |
| CourseHk | Foreign key to HubCourse | binary(32) | FK | HubCourse |
| AcademicTermHk | Foreign key to HubAcademicTerm | binary(32) | FK | HubAcademicTerm |
| SchoolHk | Foreign key to HubSchool | binary(32) | FK | HubSchool |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: LnkSectionTeacher** (Link)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| SectionTeacherHk | Hash key for the section teacher link | binary(32) | PK, HK | |
| CourseSectionHk | Foreign key to HubCourseSection | binary(32) | FK | HubCourseSection |
| TeacherHk | Foreign key to HubTeacher | binary(32) | FK | HubTeacher |
| TeacherRole | Role of the teacher in the section | varchar(20) | | |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: LnkStudentProgramme** (Link)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| StudentProgrammeHk | Hash key for the student programme link | binary(32) | PK, HK | |
| StudentHk | Foreign key to HubStudent | binary(32) | FK | HubStudent |
| ProgrammeHk | Foreign key to HubProgramme | binary(32) | FK | HubProgramme |
| SchoolHk | Foreign key to HubSchool | binary(32) | FK | HubSchool |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: LnkEnrollment** (Link)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| EnrollmentHk | Hash key for the enrollment link | binary(32) | PK, HK | |
| StudentHk | Foreign key to HubStudent | binary(32) | FK | HubStudent |
| CourseSectionHk | Foreign key to HubCourseSection | binary(32) | FK | HubCourseSection |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: LnkAttendance** (Link)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| AttendanceHk | Hash key for the attendance link | binary(32) | PK, HK | |
| StudentHk | Foreign key to HubStudent | binary(32) | FK | HubStudent |
| CourseSectionHk | Foreign key to HubCourseSection | binary(32) | FK | HubCourseSection |
| AttendanceDate | Date of attendance | date | | |
| PeriodNumber | Period number | tinyint | | |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: LnkAssessmentResult** (Link)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| AssessmentResultHk | Hash key for the assessment result link | binary(32) | PK, HK | |
| StudentHk | Foreign key to HubStudent | binary(32) | FK | HubStudent |
| AssessmentHk | Foreign key to HubAssessment | binary(32) | FK | HubAssessment |
| CourseSectionHk | Foreign key to HubCourseSection | binary(32) | FK | HubCourseSection |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: SatStudentPersonal** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| StudentHk | Foreign key to HubStudent | binary(32) | PK, FK | HubStudent |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference for change detection | binary(32) | Metadata | |
| FirstName | Student's first name | varchar(100) | | |
| MiddleName | Student's middle name | varchar(100) | | |
| LastName | Student's last name | varchar(100) | | |
| PreferredName | Student's preferred name | varchar(100) | | |
| BirthDate | Student's birth date | date | | |
| Gender | Student's gender | char(1) | | |
| Nationality | Student's nationality (ISO 3166-1 alpha-2) | varchar(2) | | |
| NativeLanguage | Student's native language | varchar(50) | | |
| Email | Student's email address | varchar(255) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: SatStudentAcademic** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| StudentHk | Foreign key to HubStudent | binary(32) | PK, FK | HubStudent |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference for change detection | binary(32) | Metadata | |
| GradeLevel | Student's grade level (e.g. Grade 11 / Year 12) | varchar(10) | | |
| IbCandidateCode | IB candidate (personal) code | varchar(20) | | |
| EnrollmentStatus | Student's enrollment status (Active, Withdrawn, Graduated) | varchar(20) | | |
| AdmissionDate | Student's admission date | date | | |
| HouseOrHomeroom | Student's house or homeroom | varchar(30) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: SatTeacherDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| TeacherHk | Foreign key to HubTeacher | binary(32) | PK, FK | HubTeacher |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference for change detection | binary(32) | Metadata | |
| FirstName | Teacher's first name | varchar(100) | | |
| LastName | Teacher's last name | varchar(100) | | |
| Email | Teacher's email address | varchar(255) | | |
| Department | Teacher's department | varchar(100) | | |
| IbWorkshopCertified | Whether the teacher is IB workshop certified | bit | | |
| IsActive | Whether the teacher is active | bit | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: SatCourseDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| CourseHk | Foreign key to HubCourse | binary(32) | PK, FK | HubCourse |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference for change detection | binary(32) | Metadata | |
| CourseName | Name of the course | varchar(200) | | |
| ProgrammeCode | Programme code (PYP, MYP, DP, CP) | varchar(10) | | |
| SubjectGroup | DP subject group (1-6) | tinyint | | |
| SubjectArea | Subject area | varchar(100) | | |
| CourseLevel | Course level (HL, SL, Standard) | varchar(10) | | |
| LanguageOfInstruction | Language of instruction | varchar(50) | | |
| TeachingHours | Recommended teaching hours | smallint | | |
| IsCore | Whether the course is a core component (TOK, EE, CAS) | bit | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: SatCourseSectionDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| CourseSectionHk | Foreign key to HubCourseSection | binary(32) | PK, FK | HubCourseSection |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference for change detection | binary(32) | Metadata | |
| SectionCode | Section code | varchar(20) | | |
| Room | Room number | varchar(30) | | |
| SchedulePeriod | Schedule period | varchar(30) | | |
| Capacity | Section capacity | smallint | | |
| SectionStatus | Section status | varchar(20) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: SatSchoolDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| SchoolHk | Foreign key to HubSchool | binary(32) | PK, FK | HubSchool |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference for change detection | binary(32) | Metadata | |
| SchoolName | Name of the school | varchar(200) | | |
| CountryCode | Country code | varchar(2) | | |
| City | City | varchar(100) | | |
| TimeZone | Time zone | varchar(50) | | |
| AuthorizedProgrammes | Authorized programmes (e.g. PYP,MYP,DP) | varchar(50) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: SatAcademicTermDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| AcademicTermHk | Foreign key to HubAcademicTerm | binary(32) | PK, FK | HubAcademicTerm |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference for change detection | binary(32) | Metadata | |
| TermName | Name of the term | varchar(50) | | |
| AcademicYear | Academic year (2025-2026) | varchar(9) | | |
| StartDate | Start date of the term | date | | |
| EndDate | End date of the term | date | | |
| InstructionalDays | Number of instructional days | smallint | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: SatProgrammeDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| ProgrammeHk | Foreign key to HubProgramme | binary(32) | PK, FK | HubProgramme |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference for change detection | binary(32) | Metadata | |
| ProgrammeName | Name of the programme | varchar(100) | | |
| AgeRange | Age range for the programme (3-12, 11-16, 16-19) | varchar(20) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: SatAssessmentDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| AssessmentHk | Foreign key to HubAssessment | binary(32) | PK, FK | HubAssessment |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference for change detection | binary(32) | Metadata | |
| AssessmentName | Name of the assessment | varchar(200) | | |
| AssessmentType | Type of assessment (IA, EE, TOK, CAS, EXAM, INTERNAL) | varchar(20) | | |
| IsInternal | Whether the assessment is internal | bit | | |
| MaxScore | Maximum possible score | decimal(8,2) | | |
| WeightPercent | Weight of the assessment in percentage | decimal(5,2) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: SatEnrollmentDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| EnrollmentHk | Foreign key to LnkEnrollment | binary(32) | PK, FK | LnkEnrollment |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference for change detection | binary(32) | Metadata | |
| EnrollmentStatus | Enrollment status (Enrolled, Dropped, Completed) | varchar(20) | | |
| CourseLevel | Course level chosen by the student (HL / SL) | varchar(10) | | |
| EnrollDate | Date of enrollment | date | | |
| DropDate | Date of dropping the course | date | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: SatStudentProgrammeDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| StudentProgrammeHk | Foreign key to LnkStudentProgramme | binary(32) | PK, FK | LnkStudentProgramme |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference for change detection | binary(32) | Metadata | |
| CandidateType | Type of candidate (Diploma, Course candidate) | varchar(30) | | |
| StartDate | Start date of the programme | date | | |
| ExpectedGraduationDate | Expected graduation date | date | | |
| ProgrammeStatus | Status in the programme | varchar(20) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: SatAttendanceDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| AttendanceHk | Foreign key to LnkAttendance | binary(32) | PK, FK | LnkAttendance |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference for change detection | binary(32) | Metadata | |
| AttendanceStatusCode | Attendance status code (P, A, L, E) | varchar(10) | | |
| MinutesLate | Minutes late | smallint | | |
| AbsenceReason | Reason for absence | varchar(200) | | |
| RecordedBy | Person who recorded the attendance | varchar(100) | | |
| RecordedDts | Date/time when attendance was recorded | datetime2(7) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: SatAssessmentResult** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| AssessmentResultHk | Foreign key to LnkAssessmentResult | binary(32) | PK, FK | LnkAssessmentResult |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference for change detection | binary(32) | Metadata | |
| RawScore | Raw score | decimal(8,2) | | |
| IbGrade | IB grade (1-7) | tinyint | | |
| PredictedGrade | Predicted IB grade (1-7) | tinyint | | |
| ResultType | Type of result (Predicted, Internal, Moderated, Final) | varchar(20) | | |
| AssessedDate | Date of assessment | date | | |
| AssessedBy | Person who assessed the result | varchar(100) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

**Table: RefAttendanceStatus** (Reference)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| AttendanceStatusCode | Attendance status code | varchar(10) | PK | |
| StatusName | Name of the status | varchar(50) | | |
| IsPresent | Whether the status means present | bit | | |
| IsExcused | Whether the status means excused | bit | | |

**Table: BvSatAttendanceSummary** (Business Vault)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| EnrollmentHk | Foreign key to LnkEnrollment | binary(32) | PK, FK | LnkEnrollment |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| DaysPresent | Number of days present | int | | |
| DaysLate | Number of days late | int | | |
| DaysAbsentExcused | Number of excused absence days | int | | |
| DaysAbsentUnexcused | Number of unexcused absence days | int | | |
| AttendancePercent | Attendance percentage | decimal(5,2) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

### Relationship Inventory

| Table Name | Column Name | Relationship Type | Referenced Table Name | Referenced Column Name |
|---|---|---|---|---|
| LnkSectionOffering | CourseSectionHk | Foreign Key | HubCourseSection | CourseSectionHk |
| LnkSectionOffering | CourseHk | Foreign Key | HubCourse | CourseHk |
| LnkSectionOffering | AcademicTermHk | Foreign Key | HubAcademicTerm | AcademicTermHk |
| LnkSectionOffering | SchoolHk | Foreign Key | HubSchool | SchoolHk |
| LnkSectionTeacher | CourseSectionHk | Foreign Key | HubCourseSection | CourseSectionHk |
| LnkSectionTeacher | TeacherHk | Foreign Key | HubTeacher | TeacherHk |
| LnkStudentProgramme | StudentHk | Foreign Key | HubStudent | StudentHk |
| LnkStudentProgramme | ProgrammeHk | Foreign Key | HubProgramme | ProgrammeHk |
| LnkStudentProgramme | SchoolHk | Foreign Key | HubSchool | SchoolHk |
| LnkEnrollment | StudentHk | Foreign Key | HubStudent | StudentHk |
| LnkEnrollment | CourseSectionHk | Foreign Key | HubCourseSection | CourseSectionHk |
| LnkAttendance | StudentHk | Foreign Key | HubStudent | StudentHk |
| LnkAttendance | CourseSectionHk | Foreign Key | HubCourseSection | CourseSectionHk |
| LnkAssessmentResult | StudentHk | Foreign Key | HubStudent | StudentHk |
| LnkAssessmentResult | AssessmentHk | Foreign Key | HubAssessment | AssessmentHk |
| LnkAssessmentResult | CourseSectionHk | Foreign Key | HubCourseSection | CourseSectionHk |
| SatStudentPersonal | StudentHk | Foreign Key | HubStudent | StudentHk |
| SatStudentAcademic | StudentHk | Foreign Key | HubStudent | StudentHk |
| SatTeacherDetails | TeacherHk | Foreign Key | HubTeacher | TeacherHk |
| SatCourseDetails | CourseHk | Foreign Key | HubCourse | CourseHk |
| SatCourseSectionDetails | CourseSectionHk | Foreign Key | HubCourseSection | CourseSectionHk |
| SatSchoolDetails | SchoolHk | Foreign Key | HubSchool | SchoolHk |
| SatAcademicTermDetails | AcademicTermHk | Foreign Key | HubAcademicTerm | AcademicTermHk |
| SatProgrammeDetails | ProgrammeHk | Foreign Key | HubProgramme | ProgrammeHk |
| SatAssessmentDetails | AssessmentHk | Foreign Key | HubAssessment | AssessmentHk |
| SatEnrollmentDetails | EnrollmentHk | Foreign Key | LnkEnrollment | EnrollmentHk |
| SatStudentProgrammeDetails | StudentProgrammeHk | Foreign Key | LnkStudentProgramme | StudentProgrammeHk |
| SatAttendanceDetails | AttendanceHk | Foreign Key | LnkAttendance | AttendanceHk |
| SatAssessmentResult | AssessmentResultHk | Foreign Key | LnkAssessmentResult | AssessmentResultHk |
| BvSatAttendanceSummary | EnrollmentHk | Foreign Key | LnkEnrollment | EnrollmentHk |

### Documentation Gaps

*   **Business Definitions**: While the DDL provides some comments, a comprehensive business glossary with detailed definitions for all terms (e.g., "HouseOrHomeroom", "IbCandidateCode") would be beneficial.
*   **Missing Descriptions**: Some column descriptions are inferred from the column name. A formal review with business stakeholders is recommended to confirm these definitions.

### Data Profiling Summary

The data profiling plan was provided in an Excel file (`IB_DataVault_Data_Profiling_Plan.xlsx`). The content of this file could not be programmatically accessed to be included in this documentation. It is recommended to extract the profiling results and include them in a future version of this document.
