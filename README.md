# Hospitality Data Analytics Project

A comprehensive business intelligence solution for analyzing hotel booking data, revenue management, and occupancy metrics across multiple hospitality properties.

---

## Table of Contents

- [Project Overview](#project-overview)
- [Project Structure](#project-structure)
- [Files & Assets](#files--assets)
- [Database Schema](#database-schema)
- [Key Metrics & KPIs](#key-metrics--kpis)
- [Dashboard Files](#dashboard-files)
- [Images & Assets](#images--assets)
- [Getting Started](#getting-started)
- [Data Model & Relationships](#data-model--relationships)
- [Usage Guide](#usage-guide)
- [Requirements & Dependencies](#requirements--dependencies)

---

## Project Overview

The **Hospitality Data Analytics Project** provides deep insights into hotel operations through multiple interactive dashboards and a comprehensive MySQL database. This solution enables hoteliers to track revenue, manage occupancy, analyze booking patterns, and make data-driven decisions.

**Project Type:** Business Intelligence Dashboard Suite  
**Technology Stack:** Power BI, MySQL Database, Tableau, Excel  
**Theme Version:** CY25SU11 (Latest Microsoft Business Theme)  
**Created:** 2025  
**Primary Focus:** Hotel Revenue Analysis, Occupancy Management, Booking Analytics, Guest Behavior

---

## Project Structure

```
Hospitality/
│
├── 📊 DASHBOARDS & VISUALIZATIONS
│   ├── Hospitality power bi Dashboard.pbix (1)/          [Power BI Dashboard - Main]
│   │   ├── Report/                                       [Report Design & Layout]
│   │   │   ├── Layout                                    [Binary: Visual page layouts]
│   │   │   ├── LinguisticSchema                          [Language & formatting settings]
│   │   │   └── StaticResources/                          [Images, themes, branding]
│   │   │       ├── RegisteredResources/
│   │   │       │   └── File_New_Power_BI_Lo*.png        [Power BI logo asset]
│   │   │       └── SharedResources/
│   │   │           └── BaseThemes/
│   │   │               └── CY25SU11.json                 [Theme config - colors, fonts, styles]
│   │   ├── DataModel                                     [Binary: Data transformations & relationships]
│   │   ├── Metadata                                      [Binary: Dashboard metadata]
│   │   ├── Settings                                      [Binary: Dashboard settings]
│   │   ├── DiagramLayout                                 [Binary: Data diagram visual]
│   │   ├── SecurityBindings                              [Binary: Row-level security (RLS)]
│   │   ├── Version                                       [Binary: Version info]
│   │   └── [Content_Types].xml                           [PBIX package manifest]
│   │
│   ├── Hospitality_Excel_Dashboard.xlsx                  [Excel Dashboard Alternative]
│   └── Tableau_Dashboard.twbx                            [Tableau Visualization]
│
├── 🗄️ DATABASE
│   └── Hospitality_MysqlFile.sql                         [Complete database schema & queries]
│
├── 📝 DOCUMENTATION
│   ├── README.md                                         [This file]
│   └── COMPREHENSIVE_README.md                           [Detailed technical documentation]
│
├── 🔧 VERSION CONTROL
│   └── .git/                                             [Git repository]
│
└── 📦 PROJECT FILES
    └── [Project metadata and configurations]

```

---

## Files & Assets

### **Top-Level Files**

| File Name | Type | Size | Description |
|-----------|------|------|-------------|
| `Hospitality power bi Dashboard.pbix (1)` | Folder | - | Main Power BI project containing the interactive dashboard |
| `Hospitality_MysqlFile.sql` | SQL Script | ~5KB | Complete MySQL database schema and analytical queries |
| `Hospitality_Excel_Dashboard.xlsx` | Excel Workbook | - | Alternative Excel-based dashboard for quick analysis |
| `Tableau_Dashboard.twbx` | Tableau Package | - | Tableau visualization alternative |
| `COMPREHENSIVE_README.md` | Markdown | - | Detailed technical documentation |
| `README.md` | Markdown | - | This file - Project overview and guide |
| `.git/` | Git Repository | - | Version control history |

### **Power BI Dashboard Structure**

#### **Report Folder Contents**

| Component | Type | Format | Purpose |
|-----------|------|--------|---------|
| `Layout` | Configuration | Binary | Stores all visual elements, page layouts, and report structure |
| `LinguisticSchema` | Configuration | Binary | Language settings, number/date formatting for dashboard localization |
| `StaticResources/` | Assets Folder | - | Static images and theme configurations |

#### **StaticResources Details**

**RegisteredResources/:**
- `File_New_Power_BI_Lo15346699400485753.png` (Image)
  - **Description:** Power BI branding logo
  - **Purpose:** Branding asset used in dashboard header/footer
  - **Format:** PNG with gold/yellow gradient
  - **Dimensions:** Used for visual branding

**SharedResources/BaseThemes/:**
- `CY25SU11.json` (Theme Configuration)
  - **Description:** Complete dashboard theme configuration file
  - **Purpose:** Defines color palette, fonts, and visual styles for all dashboard elements
  - **Key Contents:**
    - **Color Palette:** 40-color enterprise theme with primary (#118DFF), accent colors, and semantic colors
    - **Text Styles:** 
      - Callouts (DIN, 24pt)
      - Titles (DIN, 12pt)
      - Headers (Segoe UI Semibold, 12pt)
      - Labels (Segoe UI, 10pt)
    - **Visual Styling:** Configuration for all chart types, slicers, cards, tables, etc.

#### **Configuration Files**

| File | Purpose | Format |
|------|---------|--------|
| `DataModel` | Contains data transformations, calculated columns, measures, and relationships | Binary |
| `Metadata` | Dashboard metadata including descriptions and properties | Binary |
| `Settings` | Dashboard-level configuration settings | Binary (v4) |
| `DiagramLayout` | Visual representation of data relationships | Binary |
| `SecurityBindings` | Row-level security (RLS) rules for data access control | Binary |
| `Version` | Version tracking and history | Binary |
| `[Content_Types].xml` | Package manifest - lists all embedded resources and their types | XML |

---

## Database Schema

### **Database: `hospitality`**

The database uses a **Star Schema** design optimized for analytical queries and BI reporting.

### **Dimension Tables (Reference Data)**

#### **1. dim_hotels** - Hotel Properties Master Data
```sql
CREATE TABLE dim_hotels (
    property_id INT,                    -- Primary Key
    property_name VARCHAR(255),         -- Hotel/property name
    category VARCHAR(100),              -- Hotel classification (Luxury, Business, Budget, etc.)
    city VARCHAR(100)                   -- Geographic location
);
```
**Purpose:** Maintains master data for all hotel properties  
**Sample Data Structure:**
- property_id: 1, 2, 3, etc.
- property_name: Hotel ABC, Grand Resort, etc.
- category: Luxury, Business, Budget
- city: New York, Los Angeles, Chicago, etc.

**Usage:** Join with fact tables to filter/group by hotel properties and categories

---

#### **2. dim_rooms** - Room Classification & Types
```sql
CREATE TABLE dim_rooms (
    room_id VARCHAR(10),               -- Primary Key (e.g., 'ST', 'DX', 'SU')
    room_class VARCHAR(100)            -- Room type description
);
```
**Purpose:** Defines room categories and their characteristics  
**Sample Data Structure:**
- room_id: ST, DX, SU, etc.
- room_class: Standard, Deluxe, Suite, Presidential Suite, etc.

**Usage:** Analyze revenue and bookings by room category

---

#### **3. dim_date** - Time Dimension for Temporal Analysis
```sql
CREATE TABLE dim_date (
    date_str VARCHAR(20),              -- Date in string format (YYYY-MM-DD)
    mmm_yy VARCHAR(20),               -- Month-Year format (e.g., 'Jan_25', 'Feb_25')
    week_no VARCHAR(10),              -- Week number (1-52)
    day_type VARCHAR(20)              -- Day classification (Weekday, Weekend, Holiday)
);
```
**Purpose:** Enables time-based dimensional analysis  
**Sample Data Structure:**
- date_str: 2025-01-01, 2025-01-02, etc.
- mmm_yy: Jan_25, Feb_25, etc.
- week_no: 1, 2, 3, etc.
- day_type: Weekday, Weekend, Holiday

**Usage:** Analyze trends by time period, week, season, and day type

---

### **Fact Tables (Transaction Data)**

#### **4. fact_bookings** - Individual Booking Records (Transactional)
```sql
CREATE TABLE fact_bookings (
    booking_id VARCHAR(50),             -- Unique booking identifier
    property_id INT,                    -- Foreign Key → dim_hotels
    booking_date VARCHAR(20),           -- Date when booking was made
    check_in_date VARCHAR(20),          -- Guest arrival date
    checkout_date VARCHAR(20),          -- Guest departure date
    no_guests INT,                      -- Number of guests in booking
    room_category VARCHAR(10),          -- Foreign Key → dim_rooms
    booking_platform VARCHAR(50),       -- Booking source (OTA, Direct, Phone, Corporate, etc.)
    ratings_given FLOAT,                -- Guest rating (0-5 scale)
    booking_status VARCHAR(50),         -- Status: 'Confirmed', 'Checked out', 'Cancelled', 'No Show'
    revenue_generated INT,              -- Planned/quoted revenue
    revenue_realized INT                -- Actual revenue received
);
```
**Purpose:** Core transaction table - stores every individual booking  
**Key Fields:**
- **Booking Status Values:**
  - `Confirmed`: Booking is confirmed but guest hasn't checked in yet
  - `Checked out`: Guest completed stay and checked out
  - `Cancelled`: Booking was cancelled by guest or hotel
  - `No Show`: Guest didn't arrive despite confirmation

- **Revenue Fields:**
  - `revenue_generated`: Original quoted price
  - `revenue_realized`: Actual amount paid (accounts for cancellations, discounts)

- **Booking Platform:** OTA (Online Travel Agency), Direct booking, Phone, Corporate, Affiliate, etc.

**Usage:** Core data source for all booking-related metrics, revenue analysis, cancellation tracking

---

#### **5. fact_aggregated_bookings** - Daily Aggregated Occupancy Metrics
```sql
CREATE TABLE fact_aggregated_bookings (
    property_id INT,                    -- Foreign Key → dim_hotels
    check_in_date VARCHAR(20),          -- Date of check-in
    room_category VARCHAR(10),          -- Room type
    successful_bookings INT,            -- Count of completed bookings on that date
    capacity INT                        -- Total available rooms for that date/category
);
```
**Purpose:** Pre-aggregated data for occupancy rate calculations  
**Key Metrics:**
- `successful_bookings`: Number of guests checked in
- `capacity`: Total rooms available

**Calculation:**
- **Occupancy Rate** = (successful_bookings / capacity) × 100%

**Usage:** Efficient occupancy rate calculations, capacity planning

---

### **Data Relationships**

```
dim_hotels ←→ fact_bookings (property_id)
dim_rooms ←→ fact_bookings (room_category)
dim_date ←→ fact_bookings (check_in_date, checkout_date, booking_date)
dim_hotels ←→ fact_aggregated_bookings (property_id)
dim_date ←→ fact_aggregated_bookings (check_in_date)
```

---

## Key Metrics & KPIs

### **Revenue Metrics**

#### **Total Revenue**
```sql
SELECT CONCAT(ROUND(SUM(revenue_realized) / 1000000), 'M') AS total_revenue
FROM fact_bookings;
```
**Description:** Total revenue from all completed bookings  
**Format:** Displayed in millions (e.g., "15M" = $15 million)  
**Business Insight:** Overall financial performance

---

#### **Revenue by City**
```sql
SELECT dh.city, CONCAT(ROUND(SUM(fb.revenue_generated) / 1000000.0), 'M') AS Total_Revenue
FROM dim_hotels AS dh
JOIN fact_bookings AS fb ON dh.property_id = fb.property_id
GROUP BY dh.city;
```
**Description:** Revenue breakdown by geographic location  
**Usage:** Identify top-performing cities, resource allocation

---

#### **Revenue by Room Class**
```sql
SELECT dr.room_class, CONCAT(ROUND(SUM(fb.revenue_realized) / 1000000.0), 'M') AS Total_Revenue
FROM dim_rooms AS dr
JOIN fact_bookings AS fb ON dr.room_id = fb.room_category
GROUP BY dr.room_class;
```
**Description:** Revenue contribution by room type  
**Usage:** Optimize room pricing, understand room type demand

---

#### **Revenue Lost**
```sql
SELECT SUM(revenue_realized) AS revenue_lost
FROM fact_bookings
WHERE booking_status IN ('Cancelled', 'No Show');
```
**Description:** Total revenue lost due to cancellations and no-shows  
**Business Impact:** Critical for understanding cancellation policies effectiveness

---

#### **Revenue by Hotel Category**
**Description:** Revenue comparison between Luxury vs Business hotels  
**Usage:** Segment performance by hotel tier

---

### **Booking Metrics**

#### **Total Bookings**
```sql
SELECT CONCAT(ROUND(COUNT(DISTINCT booking_id) / 1000.0),'K') AS Total_Bookings
FROM fact_bookings;
```
**Description:** Total number of unique bookings  
**Format:** Displayed in thousands (e.g., "25K" = 25,000 bookings)

---

#### **Cancelled Bookings**
```sql
SELECT CONCAT(ROUND(COUNT(*) / 1000.0),'K') AS Cancelled_Booking
FROM fact_bookings
WHERE booking_status = 'Cancelled';
```
**Description:** Count of cancelled bookings  
**Format:** In thousands

---

#### **Number of Checkouts**
```sql
SELECT CONCAT(ROUND(COUNT(*) / 1000.0),'K') AS No_of_Checkouts
FROM fact_bookings
WHERE booking_status = 'Checked out';
```
**Description:** Count of completed stays (guests who checked out)  
**Usage:** Track successful room utilization

---

#### **Number of No-Shows**
```sql
SELECT CONCAT(ROUND(COUNT(*) / 1000.0),'K') AS Num_of_No_Shows
FROM fact_bookings
WHERE booking_status = 'No Show';
```
**Description:** Count of confirmed bookings where guests didn't arrive  
**Impact:** Revenue loss and wasted capacity

---

#### **Total Rooms**
```sql
SELECT CONCAT(ROUND(COUNT(DISTINCT booking_id) / 1000.0),'K') AS Total_Rooms
FROM fact_bookings;
```
**Description:** Total room bookings processed  
**Usage:** Volume metrics, bed utilization

---

### **Operational Metrics**

#### **Cancellation Rate**
```sql
SELECT CONCAT(
    ROUND(COUNT(DISTINCT CASE WHEN booking_status = 'Cancelled' THEN booking_id END) * 100 / 
    COUNT(DISTINCT booking_id)),
    '%'
) AS cancellation_rate
FROM fact_bookings;
```
**Formula:** (Cancelled Bookings / Total Bookings) × 100%  
**Industry Benchmark:** Typically 5-15% depending on hotel type  
**Usage:** Monitor booking reliability, inform cancellation policies

---

#### **Occupancy Rate**
```sql
SELECT CONCAT(ROUND(SUM(successful_bookings) / SUM(capacity) * 100),'%') AS Occupancy_Rate
FROM fact_aggregated_bookings;
```
**Formula:** (Successful Bookings / Total Capacity) × 100%  
**Industry Benchmark:** 
- Luxury Hotels: 65-75%
- Business Hotels: 70-85%
- Budget Hotels: 75-90%

**Usage:** Capacity planning, rate optimization

---

#### **Utilized Capacity (Checkout Rate)**
```sql
SELECT CONCAT(
    ROUND(COUNT(DISTINCT CASE WHEN booking_status = 'Checked Out' THEN booking_id END) / 
    COUNT(DISTINCT booking_id) * 100),
    '%'
) AS Utilized_Capacity
FROM fact_bookings;
```
**Formula:** (Checked Out Bookings / Total Bookings) × 100%  
**Usage:** Measure actual room utilization vs. bookings

---

### **Guest Metrics**

#### **Guest Ratings**
**Description:** Average rating provided by guests (typically 0-5 scale)  
**Usage:** Monitor guest satisfaction, identify service improvements

---

#### **Number of Guests**
**Description:** Average guests per booking  
**Usage:** Understand group size patterns, amenity requirements

---

#### **Booking Platform Distribution**
**Description:** Breakdown of bookings by source (OTA, Direct, Phone, Corporate, etc.)  
**Usage:** Evaluate distribution channel performance, marketing ROI

---

## Dashboard Files

### **1. Power BI Dashboard** (Primary)
**File:** `Hospitality power bi Dashboard.pbix (1)`

**Features:**
- Interactive slicers for filtering by city, hotel, room type, date range
- Real-time KPI cards showing Total Revenue, Total Bookings, Occupancy Rate, Cancellation Rate
- Revenue trend charts with time-based analysis
- Booking status distribution (pie/donut charts)
- Occupancy heatmaps by property and date
- Revenue breakdown by multiple dimensions
- Row-Level Security (RLS) for property-specific views
- Modern CY25SU11 theme with professional styling

**Software Required:** Microsoft Power BI Desktop (latest version) or Power BI Service

**How to Open:**
1. Download and install Power BI Desktop (if not already installed)
2. Open the `.pbix` file
3. The dashboard will automatically connect to the data model
4. Interact with slicers to filter data
5. Click on chart elements to drill down

---

### **2. Excel Dashboard** (Alternative)
**File:** `Hospitality_Excel_Dashboard.xlsx`

**Features:**
- Static or semi-interactive dashboard
- Pivot tables for data analysis
- Charts and graphs
- Quick reference without Power BI requirement

**Software Required:** Microsoft Excel 2016 or later

**Use Case:** Quick analysis without software dependencies, sharing with non-technical users

---

### **3. Tableau Dashboard** (Alternative)
**File:** `Tableau_Dashboard.twbx`

**Features:**
- Interactive visualizations
- Web-publishable dashboard
- Alternative visualization approach

**Software Required:** Tableau Desktop or Tableau Server access

**Use Case:** Organizations already invested in Tableau, web-based sharing

---

## Images & Assets

### **Power BI Logo**
**Location:** `Hospitality power bi Dashboard.pbix (1)/Report/StaticResources/RegisteredResources/`  
**File:** `File_New_Power_BI_Lo15346699400485753.png`

**Details:**
- **Format:** PNG image
- **Purpose:** Branding asset used in dashboard header/footer
- **Design:** Gold/Yellow gradient bars (Power BI brand colors)
- **Aspect:** Modern, professional appearance
- **Usage:** Visual branding and identity in reports

**Visual Preview:**
![Power BI Logo](https://raw.githubusercontent.com/microsoft/PowerBI-Visuals/master/Logo.png)

---

## Getting Started

### **Prerequisites**
- **For Power BI Dashboard:**
  - Microsoft Power BI Desktop (free download from Microsoft)
  - Windows 10/11 or Mac OS 10.12+
  
- **For MySQL Database:**
  - MySQL 5.7+ or MySQL 8.0+
  - SQL client tool (MySQL Workbench, DBeaver, or command line)
  
- **For Data Analysis:**
  - Python (optional) with libraries: pandas, mysql-connector-python
  - Or use Excel/Python directly

### **Setup Steps**

#### **Step 1: Set Up MySQL Database**
```bash
# 1. Open MySQL command line or client
mysql -u root -p

# 2. Execute the SQL file
SOURCE path/to/Hospitality_MysqlFile.sql;

# 3. Verify tables created
USE hospitality;
SHOW TABLES;
```

#### **Step 2: Load Data into Database**
```sql
-- Data would be loaded from CSV files or bulk import
-- This depends on your data source (ETL process)
-- Ensure data is properly formatted before import
```

#### **Step 3: Configure Power BI Connection**
1. Open Power BI Desktop
2. Click "Get Data" → "MySQL database"
3. Enter server details:
   - Server: localhost (or your server IP)
   - Database: hospitality
   - Username/Password: your MySQL credentials
4. Select tables: dim_hotels, dim_rooms, dim_date, fact_bookings, fact_aggregated_bookings
5. Click "Load"

#### **Step 4: Open Dashboard**
1. Open `Hospitality power bi Dashboard.pbix (1)` file
2. Navigate through pages using the page navigator
3. Use slicers to filter data
4. Hover over charts for additional information

---

## Data Model & Relationships

### **Star Schema Design**

```
                    dim_hotels (1)
                         |
                         |
        fact_bookings (M) ├──── fact_aggregated_bookings (M)
                         |
                    dim_date (1)
                         |
                    dim_rooms (1)
```

### **Key Relationships**

| From Table | To Table | Foreign Key | Relationship Type |
|-----------|----------|-------------|------------------|
| fact_bookings | dim_hotels | property_id | Many-to-One |
| fact_bookings | dim_rooms | room_category | Many-to-One |
| fact_bookings | dim_date | check_in_date | Many-to-One |
| fact_aggregated_bookings | dim_hotels | property_id | Many-to-One |
| fact_aggregated_bookings | dim_date | check_in_date | Many-to-One |

### **Cardinality**
- **dim_hotels:** ~10-50 properties (depends on portfolio size)
- **dim_rooms:** 4-8 room types typically
- **dim_date:** 365+ days
- **fact_bookings:** Millions of records
- **fact_aggregated_bookings:** Thousands of records

---

## Usage Guide

### **Common Analysis Scenarios**

#### **Scenario 1: Revenue Trend Analysis**
1. Open Power BI Dashboard
2. Select "Revenue Trends" page
3. Use the date slicer to select time period
4. Analyze line chart showing revenue over time
5. Click on data points for detailed breakdown

#### **Scenario 2: Occupancy Analysis**
1. Navigate to "Occupancy" page
2. Use property slicer to select hotel(s)
3. Review occupancy rate card
4. Check heatmap for peak occupancy periods
5. Identify optimization opportunities

#### **Scenario 3: Cancellation Impact**
1. Go to "Booking Analysis" page
2. Review cancellation rate KPI
3. Filter by room type or platform
4. Analyze revenue lost to cancellations
5. Develop mitigation strategies

#### **Scenario 4: Platform Performance**
1. Access "Booking Channels" page
2. Compare bookings by platform (OTA, Direct, Phone, etc.)
3. Analyze revenue per platform
4. Evaluate platform effectiveness
5. Optimize marketing spend

### **Filter & Drill-Down Tips**

- **Single Selection:** Click on slicer value
- **Multiple Selection:** Ctrl+Click on values
- **Clear Filter:** Click the eraser icon on slicer
- **Drill Down:** Click on data point in chart
- **Reset All:** Click "Reset" button if available

### **Dashboard Navigation**

- **Page Tabs:** Located at bottom, switch between different analysis views
- **Slicers:** Top section, filter all visualizations simultaneously
- **Tooltips:** Hover over any chart for additional details
- **Export Data:** Right-click chart → Export data to Excel
- **Share:** Use Power BI's sharing features for team collaboration

---

## SQL Query Reference

### **Quick KPI Queries**

All KPI queries are available in `Hospitality_MysqlFile.sql` including:

```sql
-- Revenue Analysis
- Total Revenue
- Revenue by City
- Revenue by Room Class
- Revenue by Hotel Category
- Revenue Lost

-- Booking Analysis
- Total Bookings
- Cancelled Bookings
- Checkouts
- No-Shows

-- Operational Metrics
- Cancellation Rate
- Occupancy Rate
- Utilized Capacity

-- Guest Analysis
- Guest Ratings
- Average Party Size
- Platform Distribution
```

---

## Requirements & Dependencies

### **Software Requirements**

| Component | Required | Recommended |
|-----------|----------|-------------|
| **Power BI** | Power BI Desktop | Power BI Desktop + Service |
| **Database** | MySQL 5.7+ | MySQL 8.0+ |
| **Excel** | Excel 2016+ | Excel 2021+ |
| **Tableau** | Tableau Desktop | Tableau 2023+ |
| **SQL Client** | Any | MySQL Workbench, DBeaver |

### **System Requirements**

- **RAM:** Minimum 4GB, Recommended 8GB+
- **Storage:** 100MB+ free space for files and database
- **Internet:** Required for Power BI Service (optional for Desktop)
- **Network:** Connection to MySQL server (local or remote)

### **Database Size Considerations**

- **Development:** Small dataset (GB range) for testing
- **Production:** Large dataset (TB range) with data archival strategy
- **Backup:** Regular SQL backups recommended
- **Maintenance:** Index optimization, query tuning needed for large datasets

---

## File Summary

### **Complete File Inventory**

| File/Folder | Type | Purpose | Status |
|------------|------|---------|--------|
| Hospitality power bi Dashboard.pbix (1) | Folder | Main BI dashboard | ✓ Active |
| Report/ | Folder | Dashboard design | ✓ Active |
| DataModel | Binary | Data configuration | ✓ Active |
| Metadata | Binary | Dashboard info | ✓ Active |
| Settings | Binary | Dashboard settings | ✓ Active |
| DiagramLayout | Binary | Relationship diagram | ✓ Active |
| SecurityBindings | Binary | RLS configuration | ✓ Active |
| Version | Binary | Version control | ✓ Active |
| [Content_Types].xml | XML | Package manifest | ✓ Active |
| CY25SU11.json | JSON | Theme config | ✓ Active |
| File_New_Power_BI_Logo.png | Image | Branding logo | ✓ Active |
| Hospitality_MysqlFile.sql | SQL | Database schema | ✓ Active |
| Hospitality_Excel_Dashboard.xlsx | Excel | Dashboard alt. | ✓ Active |
| Tableau_Dashboard.twbx | Tableau | Dashboard alt. | ✓ Active |
| README.md | Markdown | This file | ✓ Active |
| COMPREHENSIVE_README.md | Markdown | Technical docs | ✓ Active |
| .git/ | Git | Version control | ✓ Active |

---

## Troubleshooting

### **Common Issues**

**Issue: Dashboard won't load in Power BI**
- Solution: Update Power BI Desktop to latest version
- Check data connection settings
- Verify MySQL server is accessible

**Issue: Blank visuals/no data showing**
- Solution: Check data refresh status
- Verify date slicer isn't filtering all data
- Refresh data source in Power BI

**Issue: Slow dashboard performance**
- Solution: Reduce date range in filters
- Close other applications
- Consider using aggregated tables
- Optimize database queries

**Issue: MySQL connection fails**
- Solution: Verify MySQL server is running
- Check username/password credentials
- Ensure firewall allows connection
- Test connection from MySQL Workbench

---

## Additional Resources

### **Documentation**
- [COMPREHENSIVE_README.md](COMPREHENSIVE_README.md) - Detailed technical documentation
- SQL Query file with all KPI calculations

### **External Links**
- [Microsoft Power BI Documentation](https://docs.microsoft.com/power-bi/)
- [MySQL Database Documentation](https://dev.mysql.com/doc/)
- [Tableau Help](https://help.tableau.com/)

---

## Project Metadata

**Last Updated:** May 2026  
**Version:** 1.0  
**Author:** Data Analytics Team  
**Status:** Active/Production  
**Data Refresh:** Daily/Weekly (configure in Power BI)  
**Next Review:** Q3 2026  

---

## License & Usage

This project is designed for internal business intelligence and analytics purposes. Ensure compliance with data privacy regulations (GDPR, CCPA, etc.) when handling guest and booking data.

---

**For questions or support, contact the Data Analytics Team.**
