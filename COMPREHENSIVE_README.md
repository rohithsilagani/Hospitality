# Hospitality Power BI Dashboard - Comprehensive Project Documentation

## Project Overview

The **Hospitality Power BI Dashboard** is a comprehensive business intelligence solution designed to analyze and visualize hotel booking data. This project provides deep insights into hotel operations, revenue management, guest behavior, and occupancy metrics across multiple hospitality properties.

**Project Type:** Power BI Dashboard with Database Backend  
**Technology Stack:** Power BI, MySQL Database, Excel, Tableau  
**Date Created:** 2025 (CY25SU11 Theme Version)  
**Primary Focus:** Hotel Revenue Analysis, Occupancy Management, Booking Analytics

---

## Table of Contents

1. [Project Structure](#project-structure)
2. [Database Schema](#database-schema)
3. [Power BI Dashboard Files](#power-bi-dashboard-files)
4. [Data Files](#data-files)
5. [Key Metrics & Analytics](#key-metrics--analytics)
6. [File Descriptions](#file-descriptions)
7. [Images & Assets](#images--assets)
8. [How to Use](#how-to-use)
9. [Related Dashboards](#related-dashboards)

---

## Project Structure

```
Hospitality/
├── Hospitality power bi Dashboard.pbix (1)/          # Main Power BI Project Folder
│   ├── Report/                                        # Report Configuration
│   │   ├── Layout                                     # Report Layout File (Binary)
│   │   ├── LinguisticSchema                          # Linguistic Settings
│   │   └── StaticResources/
│   │       ├── RegisteredResources/
│   │       │   └── File_New_Power_BI_Lo*.png         # Power BI Logo Asset
│   │       └── SharedResources/
│   │           └── BaseThemes/
│   │               └── CY25SU11.json                 # Dashboard Theme Configuration
│   ├── DataModel                                      # Data Model Definition (Binary)
│   ├── Metadata                                       # Metadata Configuration (Binary)
│   ├── Settings                                       # Dashboard Settings (Binary)
│   ├── DiagramLayout                                 # Data Diagram Layout (Binary)
│   ├── SecurityBindings                              # Security Settings (Binary)
│   ├── Version                                        # Version Information (Binary)
│   └── [Content_Types].xml                           # PBIX Package Configuration
│
├── Hospitality_MysqlFile.sql                         # Database Schema & SQL Queries
├── Hospitality_Excel_Dashboard.xlsx                  # Excel-based Dashboard Alternative
├── Hospitality power bi Dashboard.pbix (1).zip       # Backup/Archive of PBIX
├── Tableau_Dashboard.twbx                           # Alternative Tableau Visualization
├── README.md                                         # Original Project README
└── .git/                                             # Version Control Repository
```

---

## Database Schema

The project uses a **MySQL relational database** with star schema design for optimal analytics performance.

### Database Name: `hospitality`

#### **Dimension Tables**

##### 1. **dim_hotels** - Hotel Properties
```sql
CREATE TABLE dim_hotels (
    property_id INT,
    property_name VARCHAR(255), 
    category VARCHAR(100),        -- e.g., 'Luxury', 'Business', etc.
    city VARCHAR(100)
);
```
**Purpose:** Stores master data for all hotel properties  
**Key Fields:** Property ID, Name, Category, Location

##### 2. **dim_rooms** - Room Classification
```sql
CREATE TABLE dim_rooms (
    room_id VARCHAR(10),
    room_class VARCHAR(100)       -- e.g., 'Standard', 'Deluxe', 'Suite', etc.
);
```
**Purpose:** Defines room types and categories  
**Key Fields:** Room ID, Room Class

##### 3. **dim_date** - Date Dimensions
```sql
CREATE TABLE dim_date (
    date_str VARCHAR(20),         -- Date in string format
    mmm_yy VARCHAR(20),          -- Month-Year format (e.g., 'Jan_25')
    week_no VARCHAR(10),         -- Week number
    day_type VARCHAR(20)         -- Type of day (e.g., 'Weekday', 'Weekend')
);
```
**Purpose:** Provides time-based dimensional analysis  
**Key Fields:** Date, Month-Year, Week Number, Day Type

#### **Fact Tables**

##### 4. **fact_bookings** - Individual Booking Records
```sql
CREATE TABLE fact_bookings (
    booking_id VARCHAR(50),
    property_id INT,
    booking_date VARCHAR(20),
    check_in_date VARCHAR(20),
    checkout_date VARCHAR(20),
    no_guests INT,
    room_category VARCHAR(10),
    booking_platform VARCHAR(50),    -- e.g., 'OTA', 'Direct', 'Phone'
    ratings_given FLOAT,
    booking_status VARCHAR(50),      -- e.g., 'Confirmed', 'Checked out', 'Cancelled', 'No Show'
    revenue_generated INT,
    revenue_realized INT
);
```
**Purpose:** Core transactional data for every booking  
**Key Fields:** Booking details, guest info, revenue, booking status

##### 5. **fact_aggregated_bookings** - Daily Aggregated Metrics
```sql
CREATE TABLE fact_aggregated_bookings (
    property_id INT,
    check_in_date VARCHAR(20),
    room_category VARCHAR(10),
    successful_bookings INT,        -- Count of completed bookings
    capacity INT                    -- Total available rooms
);
```
**Purpose:** Pre-aggregated data for occupancy and efficiency metrics  
**Key Fields:** Property, Date, Room Type, Successful Bookings, Capacity

---

## Key Metrics & Analytics

The Power BI dashboard calculates and visualizes the following KPIs:

### **Revenue Metrics**
- **Total Revenue:** Sum of all revenue realized from bookings
- **Revenue by City:** Revenue aggregated by hotel location
- **Revenue by Room Class:** Revenue breakdown by room type (Standard, Deluxe, Suite, etc.)
- **Revenue by Hotel Category:** Comparison between Luxury vs Business hotels
- **Revenue Lost:** Total revenue lost due to cancellations and no-shows

### **Booking Metrics**
- **Total Bookings:** Count of unique bookings (displayed in thousands - K format)
- **Cancelled Bookings:** Count of bookings with 'Cancelled' status
- **Number of Checkouts:** Count of 'Checked out' status bookings
- **Number of No-Shows:** Count of 'No Show' status bookings
- **Total Rooms:** Count of room bookings processed

### **Operational Metrics**
- **Cancellation Rate:** Percentage of bookings cancelled  
  `(Cancelled Bookings / Total Bookings) × 100%`
- **Occupancy Rate:** Percentage of room capacity utilized  
  `(Successful Bookings / Total Capacity) × 100%`
- **Utilized Capacity:** Percentage of checked-out bookings vs total  
  `(Checked Out Bookings / Total Bookings) × 100%`

### **Guest Metrics**
- **Guest Ratings:** Average ratings provided by guests
- **Booking Platform Analysis:** Distribution across channels (OTA, Direct, Phone, etc.)
- **No. of Guests:** Guest count per booking

---

## Power BI Dashboard Files

### **Main File: Hospitality power bi Dashboard.pbix (1)**

#### **Report Folder** - Visual Design & Layout
- **Layout:** Contains all visual elements, page designs, and report structure (binary format, not directly editable as text)
- **LinguisticSchema:** Language and formatting settings for the dashboard

#### **Static Resources**
- **RegisteredResources:** 
  - `File_New_Power_BI_Lo15346699400485753.png` - Power BI logo used as branding/asset in the dashboard

- **SharedResources - BaseThemes:**
  - `CY25SU11.json` - Complete theme configuration with color palette, fonts, and visual styles
    - **Data Colors:** 40-color palette (#118DFF, #12239E, #E66C37, etc.)
    - **Fonts:** DIN for callouts/titles, Segoe UI for labels
    - **Visual Styles:** Settings for all chart types, slicers, tables, card visuals, etc.

#### **Configuration Files**

- **DataModel:** Binary file containing the Power BI data model, transformations, and calculated columns
- **Metadata:** Configuration metadata for the dashboard
- **Settings:** Dashboard-level settings (Version 4)
- **DiagramLayout:** Visual diagram representation of data relationships
- **SecurityBindings:** Row-level security (RLS) configurations
- **Version:** Version control information
- **[Content_Types].xml:** PBIX package manifest specifying content types for all embedded resources

---

## Data Files

### **1. Hospitality_MysqlFile.sql**
**Type:** SQL Database Script  
**Purpose:** Complete database schema and analytical queries  
**Size:** ~150+ KB of SQL statements

**Contents:**
- Database creation (`CREATE DATABASE hospitality`)
- Table definitions (5 dimension/fact tables)
- Sample queries for:
  - Total revenue calculation
  - Total bookings count
  - Cancellation and no-show analysis
  - Occupancy rate calculations
  - Revenue analysis by city, room class, and hotel category
  - Revenue loss analysis
  - Detailed joins between dimension and fact tables

**Usage:** Import into MySQL Server to set up the data warehouse

---

### **2. Hospitality_Excel_Dashboard.xlsx**
**Type:** Microsoft Excel Workbook  
**Purpose:** Alternative dashboard built in Excel for on-the-go analysis  
**Format:** Excel pivot tables and charts (less interactive than Power BI)

**Use Case:** Quick analysis without Power BI Desktop

---

### **3. Hospitality power bi Dashboard.pbix (1).zip**
**Type:** ZIP Archive  
**Purpose:** Backup or distribution copy of the PBIX file  
**Contents:** Compressed version of the entire Power BI project structure

**Use Case:** Backup, version control, or secure sharing

---

### **4. Tableau_Dashboard.twbx**
**Type:** Tableau Workbook  
**Purpose:** Same analytics presented in Tableau alternative  
**Format:** Interactive Tableau dashboard

**Use Case:** For organizations using Tableau instead of Power BI, or for stakeholder presentations

---

## File Descriptions

### **Theme Configuration (CY25SU11.json)**

This JSON file defines the complete visual theme for the dashboard:

**Color Palette (40 colors):**
- Primary blue: `#118DFF`
- Accent colors including greens (`#1AAB40`), reds (`#D64550`), purples (`#6B007B`)
- Semantic colors for good/neutral/bad indicators
- Hyperlink colors

**Typography:**
- Callout: 24px DIN font
- Title/Header: 12px DIN / Segoe UI Semibold
- Labels: 10px Segoe UI

**Visual Component Styling:**
- Chart settings (gridlines, transparency, axes)
- Table and pivot table formatting
- Card visual layouts
- Slicer and filter styling
- Legend positioning and formatting

---

## Images & Assets

### **Power BI Logo**
- **File:** `File_New_Power_BI_Lo15346699400485753.png`
- **Location:** `/Report/StaticResources/RegisteredResources/`
- **Purpose:** Dashboard branding and visual identity
- **Description:** Yellow/gold gradient Power BI logo used as a header or branding element

---

## How to Use

### **Opening the Dashboard**

1. **Power BI Desktop:**
   - Open `Hospitality power bi Dashboard.pbix (1)` in Power BI Desktop
   - The dashboard will load with all visuals connected to the data model

2. **Power BI Service (Cloud):**
   - Publish the PBIX file to Power BI Service for sharing
   - Access via web browser or Power BI app

### **Setting Up the Database**

1. **MySQL Server:**
   - Open `Hospitality_MysqlFile.sql` in MySQL Workbench or Command Line
   - Execute all SQL statements to create the database and tables
   - Import your hotel booking data into the tables

2. **Connect Power BI to Database:**
   - In Power BI: Get Data → MySQL Database
   - Enter your MySQL server credentials
   - Select the `hospitality` database
   - Load the tables into the data model

### **Using the Excel Alternative**

- Open `Hospitality_Excel_Dashboard.xlsx` for quick analysis
- Use Excel's pivot table and chart features to explore data

### **Alternative Visualization (Tableau)**

- Open `Tableau_Dashboard.twbx` in Tableau Desktop or Tableau Server
- Connect to the same MySQL database
- Utilize Tableau's interactive features

---

## Key Insights & Analysis Capabilities

### **What You Can Analyze**

1. **Revenue Performance:**
   - Which cities generate the most revenue?
   - How do luxury vs business hotels compare?
   - Which room classes are most profitable?
   - How much revenue is lost to cancellations?

2. **Occupancy & Capacity:**
   - Real-time occupancy rates by property
   - Room utilization efficiency
   - Booking trends by date and day type

3. **Guest Experience:**
   - Average guest ratings by property
   - Booking platform effectiveness
   - Guest volume trends

4. **Risk Management:**
   - Cancellation rates and trends
   - No-show analysis
   - Revenue loss tracking

5. **Operational Metrics:**
   - Check-in/check-out patterns
   - Average party size
   - Booking platform distribution

---

## Version Information

- **Theme Version:** CY25SU11 (Current Year 2025, Service Update 11)
- **PBIX Version:** Power BI format (latest)
- **Settings Version:** 4
- **Database:** MySQL (Relational Schema)

---

## Project Files Summary

| File Name | Type | Size | Purpose |
|-----------|------|------|---------|
| Hospitality power bi Dashboard.pbix (1) | Folder | - | Main Power BI Project |
| Hospitality_MysqlFile.sql | SQL Script | ~150KB | Database Schema & Queries |
| Hospitality_Excel_Dashboard.xlsx | Excel | - | Alternative Excel Dashboard |
| Hospitality power bi Dashboard.pbix (1).zip | Archive | - | PBIX Backup |
| Tableau_Dashboard.twbx | Tableau | - | Alternative Tableau View |
| README.md | Documentation | 1KB | Original Project Info |
| CY25SU11.json | Theme Config | ~50KB | Dashboard Visual Theme |
| Power BI Logo PNG | Image | - | Branding Asset |

---

## Architecture Overview

```
┌─────────────────────────────────────────────────────────┐
│           Data Sources / Input Files                    │
│  (MySQL Database / Excel / CSV Files)                  │
└────────────────────┬────────────────────────────────────┘
                     │
                     ▼
        ┌────────────────────────────┐
        │   Data Warehouse (MySQL)   │
        │  ┌──────────────────────┐  │
        │  │ Dimension Tables:    │  │
        │  │ - dim_hotels         │  │
        │  │ - dim_rooms          │  │
        │  │ - dim_date           │  │
        │  ├──────────────────────┤  │
        │  │ Fact Tables:         │  │
        │  │ - fact_bookings      │  │
        │  │ - fact_aggregated    │  │
        │  └──────────────────────┘  │
        └────────────────────────────┘
                     │
          ┌──────────┼──────────┐
          │          │          │
          ▼          ▼          ▼
     ┌─────────┐ ┌────────┐ ┌──────────┐
     │ Power BI│ │ Excel  │ │ Tableau  │
     │Dashboard│ │Workbook│ │Dashboard │
     └─────────┘ └────────┘ └──────────┘
          │          │          │
          └──────────┼──────────┘
                     │
                     ▼
            ┌─────────────────────┐
            │ Business Insights & │
            │ Decision Making     │
            └─────────────────────┘
```

---

## Related Files & Dependencies

- **Version Control:** `.git/` folder contains project history
- **Backup:** `Hospitality power bi Dashboard.pbix (1).zip` - Compressed backup
- **Alternative Tools:** Excel workbook and Tableau workbook for different user preferences

---

## Notes for Users

1. **Data Refresh:** Regularly refresh Power BI connections to get the latest data from MySQL
2. **Database Maintenance:** Regular backups of the MySQL database are recommended
3. **Theme Customization:** The CY25SU11.json file can be modified to change colors and fonts
4. **Multiple Formats:** Use Power BI for detailed interactive analysis, Excel for quick access, Tableau for alternative visualization
5. **Security:** Ensure MySQL credentials are secure and RLS is properly configured for sensitive data

---

## Contact & Support

For questions or issues with:
- **Power BI Dashboard:** Check Power BI Desktop error logs
- **Database Schema:** Review SQL file comments
- **Excel Workbook:** Standard Excel pivot table troubleshooting
- **Tableau Version:** Tableau server/desktop documentation

---

**Project Documentation Created:** May 2026  
**Last Updated:** May 13, 2026  
**Documentation Version:** 1.0

---
