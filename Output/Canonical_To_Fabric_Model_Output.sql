-- Assumption: Target platform is Microsoft Fabric Warehouse / Lakehouse SQL endpoint (T-SQL compatible subset)
-- Schema assumption: using [dbo] as default schema because no custom schema standard was supplied.
-- Nullability: not specified in canonical mapping; all columns are created as NULLable per standards.
-- Keys/constraints: canonical mapping does not explicitly define primary or foreign keys; none are enforced here.

/***************************************************************************
 * Data Domain: Student and Academic Participation
 ***************************************************************************/

-- Canonical Table: STUDENT
CREATE TABLE [dbo].[STUDENT] (
    [STUDENT_ID]           NVARCHAR(50)   NULL,
    [FIRST_NAME]           NVARCHAR(100)  NULL,
    [MIDDLE_NAME]          NVARCHAR(100)  NULL,
    [LAST_NAME]            NVARCHAR(100)  NULL,
    [PREFERRED_NAME]       NVARCHAR(100)  NULL,
    [BIRTH_DATE]           DATE           NULL,
    [GENDER]               NVARCHAR(1)    NULL,
    [NATIONALITY]          NVARCHAR(2)    NULL,
    [NATIVE_LANGUAGE]      NVARCHAR(50)   NULL,
    [EMAIL]                NVARCHAR(255)  NULL,
    [GRADE_LEVEL]          NVARCHAR(10)   NULL,
    [IB_CANDIDATE_CODE]    NVARCHAR(20)   NULL,
    [ENROLLMENT_STATUS]    NVARCHAR(20)   NULL,
    [ADMISSION_DATE]       DATE           NULL,
    [HOUSE_OR_HOMEROOM]    NVARCHAR(30)   NULL
);

-- Canonical Table: STUDENT_PROGRAMME_ENROLLMENT
CREATE TABLE [dbo].[STUDENT_PROGRAMME_ENROLLMENT] (
    [STUDENT_ID]                NVARCHAR(50)  NULL,
    [PROGRAMME_CODE]            NVARCHAR(10)  NULL,
    [SCHOOL_CODE]               NVARCHAR(20)  NULL,
    [CANDIDATE_TYPE]            NVARCHAR(30)  NULL,
    [START_DATE]                DATE          NULL,
    [EXPECTED_GRADUATION_DATE]  DATE          NULL,
    [PROGRAMME_STATUS]          NVARCHAR(20)  NULL
);

-- Canonical Table: COURSE_ENROLLMENT
CREATE TABLE [dbo].[COURSE_ENROLLMENT] (
    [STUDENT_ID]         NVARCHAR(50)   NULL,
    [COURSE_SECTION_ID]  NVARCHAR(120)  NULL,
    [ENROLLMENT_STATUS]  NVARCHAR(20)   NULL,
    [COURSE_LEVEL]       NVARCHAR(10)   NULL,
    [ENROLL_DATE]        DATE           NULL,
    [DROP_DATE]          DATE           NULL
);

/***************************************************************************
 * Data Domain: Academic Structure and Delivery
 ***************************************************************************/

-- Canonical Table: SCHOOL
CREATE TABLE [dbo].[SCHOOL] (
    [SCHOOL_CODE]          NVARCHAR(20)   NULL,
    [SCHOOL_NAME]          NVARCHAR(200)  NULL,
    [COUNTRY_CODE]         NVARCHAR(2)    NULL,
    [CITY]                 NVARCHAR(100)  NULL,
    [TIME_ZONE]            NVARCHAR(50)   NULL,
    [AUTHORIZED_PROGRAMMES] NVARCHAR(50)  NULL
);

-- Canonical Table: ACADEMIC_TERM
CREATE TABLE [dbo].[ACADEMIC_TERM] (
    [ACADEMIC_TERM_CODE]  NVARCHAR(30)  NULL,
    [TERM_NAME]           NVARCHAR(50)  NULL,
    [ACADEMIC_YEAR]       NVARCHAR(9)   NULL,
    [START_DATE]          DATE          NULL,
    [END_DATE]            DATE          NULL,
    [INSTRUCTIONAL_DAYS]  INT           NULL
);

-- Canonical Table: PROGRAMME
CREATE TABLE [dbo].[PROGRAMME] (
    [PROGRAMME_CODE]  NVARCHAR(10)   NULL,
    [PROGRAMME_NAME]  NVARCHAR(100)  NULL,
    [AGE_RANGE]       NVARCHAR(20)   NULL
);

-- Canonical Table: COURSE
CREATE TABLE [dbo].[COURSE] (
    [COURSE_CODE]            NVARCHAR(50)   NULL,
    [COURSE_NAME]            NVARCHAR(200)  NULL,
    [PROGRAMME_CODE]         NVARCHAR(10)   NULL,
    [SUBJECT_GROUP]          INT            NULL,
    [SUBJECT_AREA]           NVARCHAR(100)  NULL,
    [COURSE_LEVEL]           NVARCHAR(10)   NULL,
    [LANGUAGE_OF_INSTRUCTION] NVARCHAR(50)  NULL,
    [TEACHING_HOURS]         INT            NULL,
    [IS_CORE]                BIT            NULL
);

-- Canonical Table: COURSE_SECTION
CREATE TABLE [dbo].[COURSE_SECTION] (
    [COURSE_SECTION_ID]  NVARCHAR(120)  NULL,
    [SECTION_CODE]       NVARCHAR(20)   NULL,
    [ROOM]               NVARCHAR(30)   NULL,
    [SCHEDULE_PERIOD]    NVARCHAR(30)   NULL,
    [CAPACITY]           INT            NULL,
    [SECTION_STATUS]     NVARCHAR(20)   NULL
);

-- Canonical Table: SECTION_OFFERING
CREATE TABLE [dbo].[SECTION_OFFERING] (
    [COURSE_SECTION_ID]   NVARCHAR(120)  NULL,
    [COURSE_CODE]         NVARCHAR(50)   NULL,
    [ACADEMIC_TERM_CODE]  NVARCHAR(30)   NULL,
    [SCHOOL_CODE]         NVARCHAR(20)   NULL
);

-- Canonical Table: TEACHER
CREATE TABLE [dbo].[TEACHER] (
    [TEACHER_ID]            NVARCHAR(50)   NULL,
    [FIRST_NAME]            NVARCHAR(100)  NULL,
    [LAST_NAME]             NVARCHAR(100)  NULL,
    [EMAIL]                 NVARCHAR(255)  NULL,
    [DEPARTMENT]            NVARCHAR(100)  NULL,
    [IB_WORKSHOP_CERTIFIED] BIT            NULL,
    [IS_ACTIVE]             BIT            NULL
);

-- Canonical Table: SECTION_TEACHER_ASSIGNMENT
CREATE TABLE [dbo].[SECTION_TEACHER_ASSIGNMENT] (
    [COURSE_SECTION_ID]  NVARCHAR(120)  NULL,
    [TEACHER_ID]         NVARCHAR(50)   NULL,
    [TEACHER_ROLE]       NVARCHAR(20)   NULL
);

/***************************************************************************
 * Data Domain: Attendance and Engagement
 ***************************************************************************/

-- Canonical Table: ATTENDANCE_EVENT
CREATE TABLE [dbo].[ATTENDANCE_EVENT] (
    [STUDENT_ID]              NVARCHAR(50)   NULL,
    [COURSE_SECTION_ID]       NVARCHAR(120)  NULL,
    [ATTENDANCE_DATE]         DATE           NULL,
    [PERIOD_NUMBER]           INT            NULL,
    [ATTENDANCE_STATUS_CODE]  NVARCHAR(10)   NULL,
    [MINUTES_LATE]            INT            NULL,
    [ABSENCE_REASON]          NVARCHAR(200)  NULL,
    [RECORDED_BY]             NVARCHAR(100)  NULL,
    [RECORDED_DTS]            DATETIME2(7)   NULL
);

-- Canonical Table: ATTENDANCE_STATUS
CREATE TABLE [dbo].[ATTENDANCE_STATUS] (
    [ATTENDANCE_STATUS_CODE]  NVARCHAR(10)   NULL,
    [STATUS_NAME]             NVARCHAR(50)   NULL,
    [IS_PRESENT]              BIT            NULL,
    [IS_EXCUSED]              BIT            NULL
);

-- Canonical Table: ENROLLMENT_ATTENDANCE_SUMMARY
CREATE TABLE [dbo].[ENROLLMENT_ATTENDANCE_SUMMARY] (
    [STUDENT_ID]              NVARCHAR(50)   NULL,
    [COURSE_SECTION_ID]       NVARCHAR(120)  NULL,
    [DAYS_PRESENT]            INT            NULL,
    [DAYS_LATE]               INT            NULL,
    [DAYS_ABSENT_EXCUSED]     INT            NULL,
    [DAYS_ABSENT_UNEXCUSED]   INT            NULL,
    [ATTENDANCE_PERCENT]      DECIMAL(5,2)   NULL
);

/***************************************************************************
 * Data Domain: Assessment and Academic Performance
 ***************************************************************************/

-- Canonical Table: ASSESSMENT
CREATE TABLE [dbo].[ASSESSMENT] (
    [ASSESSMENT_CODE]  NVARCHAR(60)   NULL,
    [ASSESSMENT_NAME]  NVARCHAR(200)  NULL,
    [ASSESSMENT_TYPE]  NVARCHAR(20)   NULL,
    [IS_INTERNAL]      BIT            NULL,
    [MAX_SCORE]        DECIMAL(8,2)   NULL,
    [WEIGHT_PERCENT]   DECIMAL(5,2)   NULL
);

-- Canonical Table: ASSESSMENT_RESULT
CREATE TABLE [dbo].[ASSESSMENT_RESULT] (
    [STUDENT_ID]        NVARCHAR(50)   NULL,
    [ASSESSMENT_CODE]   NVARCHAR(60)   NULL,
    [COURSE_SECTION_ID] NVARCHAR(120)  NULL,
    [RAW_SCORE]         DECIMAL(8,2)   NULL,
    [IB_GRADE]          INT            NULL,
    [PREDICTED_GRADE]   INT            NULL,
    [RESULT_TYPE]       NVARCHAR(20)   NULL,
    [ASSESSED_DATE]     DATE           NULL,
    [ASSESSED_BY]       NVARCHAR(100)  NULL
);

-- End of Canonical_To_Fabric_Model_Output.sql
