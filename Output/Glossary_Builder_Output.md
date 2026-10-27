### Executive Overview
This report provides a comprehensive data dictionary and glossary for the International Baccalaureate (IB) School Data Vault 2.0 model, as defined in `IB_datavault2.sql`. The data model consists of 29 tables, classified as Hubs, Links, Satellites, a Reference table, and a Business Vault table. All table and column definitions have been extracted directly from the DDL. Business descriptions are derived from DDL comments; where no comments were present, definitions are marked as requiring business input. The analysis also identifies 30 foreign key relationships and a significant documentation gap: the absence of a foreign key constraint between `SatAttendanceDetails` and the `RefAttendanceStatus` table it logically references. Data profiling checks have been documented based on the `IB_DataVault_Data_Profiling_Plan.xlsx` plan, but no actual data profiling has been executed, so all checks are marked as `NOT_RUN`.

### Table Inventory
| Schema | Table Name | Table Type | Business Description |
|---|---|---|---|
| Ib | HubStudent | Hub | Business definition required |
| Ib | HubTeacher | Hub | Business definition required |
| Ib | HubCourse | Hub | Business definition required |
| Ib | HubCourseSection | Hub | Business definition required |
| Ib | HubSchool | Hub | Business definition required |
| Ib | HubAcademicTerm | Hub | Business definition required |
| Ib | HubProgramme | Hub | Business definition required |
| Ib | HubAssessment | Hub | Business definition required |
| Ib | LnkSectionOffering | Link | A section is one course offered in one term at one school |
| Ib | LnkSectionTeacher | Link | Teacher assigned to a section, by role (PRIMARY, CO-TEACHER, SUBSTITUTE) |
| Ib | LnkStudentProgramme | Link | Student in an IB programme at a school |
| Ib | LnkEnrollment | Link | Student enrolled in a section |
| Ib | LnkAttendance | Link | Attendance event: student + section + date + period (period is a dependent child key) |
| Ib | LnkAssessmentResult | Link | Student result for an assessment in a section |
| Ib | SatStudentPersonal | Satellite | Student PII split from academic attributes |
| Ib | SatStudentAcademic | Satellite | Business definition required |
| Ib | SatTeacherDetails | Satellite | Business definition required |
| Ib | SatCourseDetails | Satellite | Business definition required |
| Ib | SatCourseSectionDetails | Satellite | Business definition required |
| Ib | SatSchoolDetails | Satellite | Business definition required |
| Ib | SatAcademicTermDetails | Satellite | Business definition required |
| Ib | SatProgrammeDetails | Satellite | Business definition required |
| Ib | SatAssessmentDetails | Satellite | Business definition required |
| Ib | SatEnrollmentDetails | Satellite | Link satellite |
| Ib | SatStudentProgrammeDetails | Satellite | Business definition required |
| Ib | SatAttendanceDetails | Satellite | Business definition required |
| Ib | SatAssessmentResult | Satellite | Business definition required |
| Ib | RefAttendanceStatus | Reference | Business definition required |
| Ib | BvSatAttendanceSummary | Business Vault | Business Vault: attendance summary per enrollment (computed satellite) |

### Column Data Dictionary
**Table: HubStudent** (Hub)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| StudentHk | Business definition required | binary(32) | PK | |
| StudentBk | school student ID | varchar(50) | BK | |
| LoadDts | Business definition required | datetime2(7) | Metadata | |
| RecordSource | Business definition required | varchar(100) | Metadata | |

**Table: HubTeacher** (Hub)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| TeacherHk | Business definition required | binary(32) | PK | |
| TeacherBk | staff ID | varchar(50) | BK | |
| LoadDts | Business definition required | datetime2(7) | Metadata | |
| RecordSource | Business definition required | varchar(100) | Metadata | |

**Table: HubCourse** (Hub)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| CourseHk | Business definition required | binary(32) | PK | |
| CourseBk | e.g. MATH-AA-HL | varchar(50) | BK | |
| LoadDts | Business definition required | datetime2(7) | Metadata | |
| RecordSource | Business definition required | varchar(100) | Metadata | |

**Table: HubCourseSection** (Hub)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| CourseSectionHk | Business definition required | binary(32) | PK | |
| CourseSectionBk | SchoolCode||TermCode||CourseCode||SectionCode | varchar(120) | BK | |
| LoadDts | Business definition required | datetime2(7) | Metadata | |
| RecordSource | Business definition required | varchar(100) | Metadata | |

**Table: HubSchool** (Hub)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| SchoolHk | Business definition required | binary(32) | PK | |
| SchoolBk | IB school code | varchar(20) | BK | |
| LoadDts | Business definition required | datetime2(7) | Metadata | |
| RecordSource | Business definition required | varchar(100) | Metadata | |

**Table: HubAcademicTerm** (Hub)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| AcademicTermHk | Business definition required | binary(32) | PK | |
| AcademicTermBk | e.g. 2025-FALL | varchar(30) | BK | |
| LoadDts | Business definition required | datetime2(7) | Metadata | |
| RecordSource | Business definition required | varchar(100) | Metadata | |

**Table: HubProgramme** (Hub)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| ProgrammeHk | Business definition required | binary(32) | PK | |
| ProgrammeBk | PYP, MYP, DP, CP | varchar(10) | BK | |
| LoadDts | Business definition required | datetime2(7) | Metadata | |
| RecordSource | Business definition required | varchar(100) | Metadata | |

**Table: HubAssessment** (Hub)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| AssessmentHk | Business definition required | binary(32) | PK | |
| AssessmentBk | e.g. MATH-AA-HL-IA, EE, TOK-ESSAY, CAS | varchar(60) | BK | |
| LoadDts | Business definition required | datetime2(7) | Metadata | |
| RecordSource | Business definition required | varchar(100) | Metadata | |

**Table: LnkSectionOffering** (Link)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| SectionOfferingHk | Business definition required | binary(32) | PK | |
| CourseSectionHk | Business definition required | binary(32) | FK | HubCourseSection |
| CourseHk | Business definition required | binary(32) | FK | HubCourse |
| AcademicTermHk | Business definition required | binary(32) | FK | HubAcademicTerm |
| SchoolHk | Business definition required | binary(32) | FK | HubSchool |
| LoadDts | Business definition required | datetime2(7) | Metadata | |
| RecordSource | Business definition required | varchar(100) | Metadata | |

**Table: LnkSectionTeacher** (Link)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| SectionTeacherHk | Business definition required | binary(32) | PK | |
| CourseSectionHk | Business definition required | binary(32) | FK | HubCourseSection |
| TeacherHk | Business definition required | binary(32) | FK | HubTeacher |
| TeacherRole | Business definition required | varchar(20) | | |
| LoadDts | Business definition required | datetime2(7) | Metadata | |
| RecordSource | Business definition required | varchar(100) | Metadata | |

**Table: LnkStudentProgramme** (Link)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| StudentProgrammeHk | Business definition required | binary(32) | PK | |
| StudentHk | Business definition required | binary(32) | FK | HubStudent |
| ProgrammeHk | Business definition required | binary(32) | FK | HubProgramme |
| SchoolHk | Business definition required | binary(32) | FK | HubSchool |
| LoadDts | Business definition required | datetime2(7) | Metadata | |
| RecordSource | Business definition required | varchar(100) | Metadata | |

**Table: LnkEnrollment** (Link)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| EnrollmentHk | Business definition required | binary(32) | PK | |
| StudentHk | Business definition required | binary(32) | FK | HubStudent |
| CourseSectionHk | Business definition required | binary(32) | FK | HubCourseSection |
| LoadDts | Business definition required | datetime2(7) | Metadata | |
| RecordSource | Business definition required | varchar(100) | Metadata | |

**Table: LnkAttendance** (Link)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| AttendanceHk | Business definition required | binary(32) | PK | |
| StudentHk | Business definition required | binary(32) | FK | HubStudent |
| CourseSectionHk | Business definition required | binary(32) | FK | HubCourseSection |
| AttendanceDate | Business definition required | date | | |
| PeriodNumber | Business definition required | tinyint | | |
| LoadDts | Business definition required | datetime2(7) | Metadata | |
| RecordSource | Business definition required | varchar(100) | Metadata | |

**Table: LnkAssessmentResult** (Link)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| AssessmentResultHk | Business definition required | binary(32) | PK | |
| StudentHk | Business definition required | binary(32) | FK | HubStudent |
| AssessmentHk | Business definition required | binary(32) | FK | HubAssessment |
| CourseSectionHk | Business definition required | binary(32) | FK | HubCourseSection |
| LoadDts | Business definition required | datetime2(7) | Metadata | |
| RecordSource | Business definition required | varchar(100) | Metadata | |

**Table: SatStudentPersonal** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| StudentHk | Business definition required | binary(32) | PK, FK | HubStudent |
| LoadDts | Business definition required | datetime2(7) | PK, Metadata | |
| LoadEndDts | Business definition required | datetime2(7) | Metadata | |
| HashDiff | Business definition required | binary(32) | Metadata | |
| FirstName | Business definition required | varchar(100) | | |
| MiddleName | Business definition required | varchar(100) | | |
| LastName | Business definition required | varchar(100) | | |
| PreferredName | Business definition required | varchar(100) | | |
| BirthDate | Business definition required | date | | |
| Gender | Business definition required | char(1) | | |
| Nationality | ISO 3166-1 alpha-2 | varchar(2) | | |
| NativeLanguage | Business definition required | varchar(50) | | |
| Email | Business definition required | varchar(255) | | |
| RecordSource | Business definition required | varchar(100) | Metadata | |

**Table: SatStudentAcademic** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| StudentHk | Business definition required | binary(32) | PK, FK | HubStudent |
| LoadDts | Business definition required | datetime2(7) | PK, Metadata | |
| LoadEndDts | Business definition required | datetime2(7) | Metadata | |
| HashDiff | Business definition required | binary(32) | Metadata | |
| GradeLevel | e.g. Grade 11 / Year 12 | varchar(10) | | |
| IbCandidateCode | IB candidate (personal) code | varchar(20) | | |
| EnrollmentStatus | Active, Withdrawn, Graduated | varchar(20) | | |
| AdmissionDate | Business definition required | date | | |
| HouseOrHomeroom | Business definition required | varchar(30) | | |
| RecordSource | Business definition required | varchar(100) | Metadata | |

**Table: SatTeacherDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| TeacherHk | Business definition required | binary(32) | PK, FK | HubTeacher |
| LoadDts | Business definition required | datetime2(7) | PK, Metadata | |
| LoadEndDts | Business definition required | datetime2(7) | Metadata | |
| HashDiff | Business definition required | binary(32) | Metadata | |
| FirstName | Business definition required | varchar(100) | | |
| LastName | Business definition required | varchar(100) | | |
| Email | Business definition required | varchar(255) | | |
| Department | Business definition required | varchar(100) | | |
| IbWorkshopCertified | Business definition required | bit | | |
| IsActive | Business definition required | bit | | |
| RecordSource | Business definition required | varchar(100) | Metadata | |

**Table: SatCourseDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| CourseHk | Business definition required | binary(32) | PK, FK | HubCourse |
| LoadDts | Business definition required | datetime2(7) | PK, Metadata | |
| LoadEndDts | Business definition required | datetime2(7) | Metadata | |
| HashDiff | Business definition required | binary(32) | Metadata | |
| CourseName | Business definition required | varchar(200) | | |
| ProgrammeCode | PYP, MYP, DP, CP | varchar(10) | | |
| SubjectGroup | DP groups 1-6 | tinyint | | |
| SubjectArea | Business definition required | varchar(100) | | |
| CourseLevel | HL, SL, Standard | varchar(10) | | |
| LanguageOfInstruction | Business definition required | varchar(50) | | |
| TeachingHours | 240 HL / 150 SL | smallint | | |
| IsCore | TOK, EE, CAS | bit | | |
| RecordSource | Business definition required | varchar(100) | Metadata | |

**Table: SatCourseSectionDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| CourseSectionHk | Business definition required | binary(32) | PK, FK | HubCourseSection |
| LoadDts | Business definition required | datetime2(7) | PK, Metadata | |
| LoadEndDts | Business definition required | datetime2(7) | Metadata | |
| HashDiff | Business definition required | binary(32) | Metadata | |
| SectionCode | Business definition required | varchar(20) | | |
| Room | Business definition required | varchar(30) | | |
| SchedulePeriod | Business definition required | varchar(30) | | |
| Capacity | Business definition required | smallint | | |
| SectionStatus | Business definition required | varchar(20) | | |
| RecordSource | Business definition required | varchar(100) | Metadata | |

**Table: SatSchoolDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| SchoolHk | Business definition required | binary(32) | PK, FK | HubSchool |
| LoadDts | Business definition required | datetime2(7) | PK, Metadata | |
| LoadEndDts | Business definition required | datetime2(7) | Metadata | |
| HashDiff | Business definition required | binary(32) | Metadata | |
| SchoolName | Business definition required | varchar(200) | | |
| CountryCode | Business definition required | varchar(2) | | |
| City | Business definition required | varchar(100) | | |
| TimeZone | Business definition required | varchar(50) | | |
| AuthorizedProgrammes | e.g. PYP,MYP,DP | varchar(50) | | |
| RecordSource | Business definition required | varchar(100) | Metadata | |

**Table: SatAcademicTermDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| AcademicTermHk | Business definition required | binary(32) | PK, FK | HubAcademicTerm |
| LoadDts | Business definition required | datetime2(7) | PK, Metadata | |
| LoadEndDts | Business definition required | datetime2(7) | Metadata | |
| HashDiff | Business definition required | binary(32) | Metadata | |
| TermName | Business definition required | varchar(50) | | |
| AcademicYear | 2025-2026 | varchar(9) | | |
| StartDate | Business definition required | date | | |
| EndDate | Business definition required | date | | |
| InstructionalDays | Business definition required | smallint | | |
| RecordSource | Business definition required | varchar(100) | Metadata | |

**Table: SatProgrammeDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| ProgrammeHk | Business definition required | binary(32) | PK, FK | HubProgramme |
| LoadDts | Business definition required | datetime2(7) | PK, Metadata | |
| LoadEndDts | Business definition required | datetime2(7) | Metadata | |
| HashDiff | Business definition required | binary(32) | Metadata | |
| ProgrammeName | Business definition required | varchar(100) | | |
| AgeRange | 3-12, 11-16, 16-19 | varchar(20) | | |
| RecordSource | Business definition required | varchar(100) | Metadata | |

**Table: SatAssessmentDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| AssessmentHk | Business definition required | binary(32) | PK, FK | HubAssessment |
| LoadDts | Business definition required | datetime2(7) | PK, Metadata | |
| LoadEndDts | Business definition required | datetime2(7) | Metadata | |
| HashDiff | Business definition required | binary(32) | Metadata | |
| AssessmentName | Business definition required | varchar(200) | | |
| AssessmentType | IA, EE, TOK, CAS, EXAM, INTERNAL | varchar(20) | | |
| IsInternal | Business definition required | bit | | |
| MaxScore | Business definition required | decimal(8,2) | | |
| WeightPercent | Business definition required | decimal(5,2) | | |
| RecordSource | Business definition required | varchar(100) | Metadata | |

**Table: SatEnrollmentDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| EnrollmentHk | Business definition required | binary(32) | PK, FK | LnkEnrollment |
| LoadDts | Business definition required | datetime2(7) | PK, Metadata | |
| LoadEndDts | Business definition required | datetime2(7) | Metadata | |
| HashDiff | Business definition required | binary(32) | Metadata | |
| EnrollmentStatus | Enrolled, Dropped, Completed | varchar(20) | | |
| CourseLevel | HL / SL chosen by the student | varchar(10) | | |
| EnrollDate | Business definition required | date | | |
| DropDate | Business definition required | date | | |
| RecordSource | Business definition required | varchar(100) | Metadata | |

**Table: SatStudentProgrammeDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| StudentProgrammeHk | Business definition required | binary(32) | PK, FK | LnkStudentProgramme |
| LoadDts | Business definition required | datetime2(7) | PK, Metadata | |
| LoadEndDts | Business definition required | datetime2(7) | Metadata | |
| HashDiff | Business definition required | binary(32) | Metadata | |
| CandidateType | Diploma, Course candidate | varchar(30) | | |
| StartDate | Business definition required | date | | |
| ExpectedGraduationDate | Business definition required | date | | |
| ProgrammeStatus | Business definition required | varchar(20) | | |
| RecordSource | Business definition required | varchar(100) | Metadata | |

**Table: SatAttendanceDetails** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| AttendanceHk | Business definition required | binary(32) | PK, FK | LnkAttendance |
| LoadDts | Business definition required | datetime2(7) | PK, Metadata | |
| LoadEndDts | Business definition required | datetime2(7) | Metadata | |
| HashDiff | Business definition required | binary(32) | Metadata | |
| AttendanceStatusCode | P, A, L, E (see RefAttendanceStatus) | varchar(10) | | |
| MinutesLate | Business definition required | smallint | | |
| AbsenceReason | Business definition required | varchar(200) | | |
| RecordedBy | Business definition required | varchar(100) | | |
| RecordedDts | Business definition required | datetime2(7) | | |
| RecordSource | Business definition required | varchar(100) | Metadata | |

**Table: SatAssessmentResult** (Satellite)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| AssessmentResultHk | Business definition required | binary(32) | PK, FK | LnkAssessmentResult |
| LoadDts | Business definition required | datetime2(7) | PK, Metadata | |
| LoadEndDts | Business definition required | datetime2(7) | Metadata | |
| HashDiff | Business definition required | binary(32) | Metadata | |
| RawScore | Business definition required | decimal(8,2) | | |
| IbGrade | 1-7 | tinyint | | |
| PredictedGrade | 1-7 | tinyint | | |
| ResultType | Predicted, Internal, Moderated, Final | varchar(20) | | |
| AssessedDate | Business definition required | date | | |
| AssessedBy | Business definition required | varchar(100) | | |
| RecordSource | Business definition required | varchar(100) | Metadata | |

**Table: RefAttendanceStatus** (Reference)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| AttendanceStatusCode | Business definition required | varchar(10) | PK | |
| StatusName | Business definition required | varchar(50) | | |
| IsPresent | Business definition required | bit | | |
| IsExcused | Business definition required | bit | | |

**Table: BvSatAttendanceSummary** (Business Vault)
| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| EnrollmentHk | Business definition required | binary(32) | PK, FK | LnkEnrollment |
| LoadDts | Business definition required | datetime2(7) | PK, Metadata | |
| LoadEndDts | Business definition required | datetime2(7) | Metadata | |
| DaysPresent | Business definition required | int | | |
| DaysLate | Business definition required | int | | |
| DaysAbsentExcused | Business definition required | int | | |
| DaysAbsentUnexcused | Business definition required | int | | |
| AttendancePercent | Business definition required | decimal(5,2) | | |
| RecordSource | Business definition required | varchar(100) | Metadata | |

### Relationship Inventory
| Table Name | Column Name | Relationship Type | Referenced Table Name | Referenced Column Name |
|---|---|---|---|---|
| LnkSectionOffering | CourseSectionHk | FK | HubCourseSection | CourseSectionHk |
| LnkSectionOffering | CourseHk | FK | HubCourse | CourseHk |
| LnkSectionOffering | AcademicTermHk | FK | HubAcademicTerm | AcademicTermHk |
| LnkSectionOffering | SchoolHk | FK | HubSchool | SchoolHk |
| LnkSectionTeacher | CourseSectionHk | FK | HubCourseSection | CourseSectionHk |
| LnkSectionTeacher | TeacherHk | FK | HubTeacher | TeacherHk |
| LnkStudentProgramme | StudentHk | FK | HubStudent | StudentHk |
| LnkStudentProgramme | ProgrammeHk | FK | HubProgramme | ProgrammeHk |
| LnkStudentProgramme | SchoolHk | FK | HubSchool | SchoolHk |
| LnkEnrollment | StudentHk | FK | HubStudent | StudentHk |
| LnkEnrollment | CourseSectionHk | FK | HubCourseSection | CourseSectionHk |
| LnkAttendance | StudentHk | FK | HubStudent | StudentHk |
| LnkAttendance | CourseSectionHk | FK | HubCourseSection | CourseSectionHk |
| LnkAssessmentResult | StudentHk | FK | HubStudent | StudentHk |
| LnkAssessmentResult | AssessmentHk | FK | HubAssessment | AssessmentHk |
| LnkAssessmentResult | CourseSectionHk | FK | HubCourseSection | CourseSectionHk |
| SatStudentPersonal | StudentHk | FK | HubStudent | StudentHk |
| SatStudentAcademic | StudentHk | FK | HubStudent | StudentHk |
| SatTeacherDetails | TeacherHk | FK | HubTeacher | TeacherHk |
| SatCourseDetails | CourseHk | FK | HubCourse | CourseHk |
| SatCourseSectionDetails | CourseSectionHk | FK | HubCourseSection | CourseSectionHk |
| SatSchoolDetails | SchoolHk | FK | HubSchool | SchoolHk |
| SatAcademicTermDetails | AcademicTermHk | FK | HubAcademicTerm | AcademicTermHk |
| SatProgrammeDetails | ProgrammeHk | FK | HubProgramme | ProgrammeHk |
| SatAssessmentDetails | AssessmentHk | FK | HubAssessment | AssessmentHk |
| SatEnrollmentDetails | EnrollmentHk | FK | LnkEnrollment | EnrollmentHk |
| SatStudentProgrammeDetails | StudentProgrammeHk | FK | LnkStudentProgramme | StudentProgrammeHk |
| SatAttendanceDetails | AttendanceHk | FK | LnkAttendance | AttendanceHk |
| SatAssessmentResult | AssessmentResultHk | FK | LnkAssessmentResult | AssessmentResultHk |
| BvSatAttendanceSummary | EnrollmentHk | FK | LnkEnrollment | EnrollmentHk |

### Documentation Gaps
| Table Name | Column Name | Gap Type | Description | Recommended Clarification |
|---|---|---|---|---|
| SatAttendanceDetails | AttendanceStatusCode | Missing Relationship | The `AttendanceStatusCode` column logically relates to the `RefAttendanceStatus` table but has no declared foreign key constraint. | Define a foreign key constraint from `SatAttendanceDetails(AttendanceStatusCode)` to `RefAttendanceStatus(AttendanceStatusCode)` to enforce referential integrity. |
| Multiple | Multiple | Missing Business Definition | Many tables and columns lack formal business descriptions in the DDL comments. | Engage with business subject matter experts to document clear, concise definitions for all tables and columns currently marked 'Business definition required'. |
| HubCourseSection | CourseSectionBk | Unclear Terminology | The business key format is listed as `SchoolCode||TermCode||CourseCode||SectionCode`, but the specific source for each element is not defined. | Provide a clear definition and source for each component of the composite business key. |

### Data Profiling Summary
| Table Name | Column Name | Profiling Check | Result | Count | Percentage | Status |
|---|---|---|---|---|---|---|
| HubStudent | StudentBk | Uniqueness | Business definition required | Business definition required | Business definition required | NOT_RUN |
| HubStudent | StudentBk | Nulls | Business definition required | Business definition required | Business definition required | NOT_RUN |
| SatStudentPersonal | Email | Email Format | Business definition required | Business definition required | Business definition required | NOT_RUN |
| SatStudentPersonal | Nationality | ISO 3166-1 alpha-2 format | Business definition required | Business definition required | Business definition required | NOT_RUN |
| SatAttendanceDetails | AttendanceStatusCode | Value Distribution | Business definition required | Business definition required | Business definition required | NOT_RUN |
| SatAttendanceDetails | AttendanceStatusCode | Referential Integrity vs RefAttendanceStatus | Business definition required | Business definition required | Business definition required | NOT_RUN |
| RefAttendanceStatus | ALL | Seed Data Verification | Business definition required | 4 | 100% | DDL_REVIEWED |
| BvSatAttendanceSummary | AttendancePercent | Range Check (0-100) | Business definition required | Business definition required | Business definition required | NOT_RUN |
| ALL | ALL | All data-dependent checks | Business definition required | Business definition required | Business definition required | NOT_RUN |
