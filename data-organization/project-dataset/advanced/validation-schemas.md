# JSON Schema Validation for Image Metadata

## Overview

JSON Schema Validation allows you to enforce a consistent structure for image metadata when uploading images to projects. This feature ensures that all images in your project have metadata that follows a predefined JSON schema, preventing inconsistent or incomplete metadata uploads.

## How It Works

When uploading images with custom metadata, Supervisely can validate that metadata against a JSON schema you define for the project. If the metadata doesn't match the schema, the upload will fail with a detailed error message.

## Use Case Example

Imagine you're uploading images to a project where each image needs specific metadata:
- Camera settings (ISO, aperture, shutter speed)
- Location information (GPS coordinates, address)
- Quality metrics (brightness, contrast, sharpness)

Without validation, different team members might upload images with inconsistent metadata structure. With JSON schema validation, you ensure all metadata follows the same format.

## Setting Up Validation

### Step 1: Define Your Schema

Create a JSON schema that defines the required structure for your image metadata. For example:

```json
{
  "type": "object",
  "required": ["camera", "location", "quality"],
  "properties": {
    "camera": {
      "type": "object",
      "required": ["iso", "aperture"],
      "properties": {
        "iso": {"type": "number"},
        "aperture": {"type": "string"},
        "shutter_speed": {"type": "string"}
      }
    },
    "location": {
      "type": "object",
      "required": ["lat", "lng"],
      "properties": {
        "lat": {"type": "number"},
        "lng": {"type": "number"},
        "address": {"type": "string"}
      }
    },
    "quality": {
      "type": "object",
      "properties": {
        "brightness": {"type": "number"},
        "contrast": {"type": "number"}
      }
    }
  }
}
```

### Step 2: Set Schema for Project

Apply the schema to your project through the Supervisely interface or API. Once set, this schema will be used to validate all future image metadata uploads.

### Step 3: Upload Images with Validation

When uploading images, you can enable validation to ensure metadata compliance. Valid metadata example:

```json
{
  "camera": {
    "iso": 800,
    "aperture": "f/2.8",
    "shutter_speed": "1/60"
  },
  "location": {
    "lat": 37.7749,
    "lng": -122.4194,
    "address": "San Francisco, CA"
  },
  "quality": {
    "brightness": 0.7,
    "contrast": 0.8
  }
}
```

## Validation Options

### Standard Validation
- Checks for required fields
- Ignores extra fields not defined in schema
- Allows flexible metadata structure

### Strict Validation
- Requires exact schema match
- Fails on missing OR extra fields
- Enforces rigid metadata structure

## Validating Existing Projects

For projects with existing images, you can:

1. **Set a new schema** for the project
2. **Run validation** on all existing images
3. **Get detailed reports** of which images have invalid metadata
4. **Fix metadata** for non-compliant images

This is useful when:
- Adding validation to an existing project
- Updating schema requirements
- Auditing metadata quality across your dataset

## Benefits

- **Consistency**: All images have the same metadata structure
- **Quality Control**: Prevent incomplete or incorrect metadata uploads
- **Team Coordination**: Everyone follows the same metadata standards
- **Data Integrity**: Maintain clean, structured datasets
- **Error Prevention**: Catch metadata issues at upload time

## Common Schema Patterns

### Simple Required Fields
```json
{
  "type": "object",
  "required": ["timestamp", "source"],
  "properties": {
    "timestamp": {"type": "string"},
    "source": {"type": "string"}
  }
}
```

### Nested Structures
```json
{
  "type": "object",
  "required": ["equipment"],
  "properties": {
    "equipment": {
      "type": "object",
      "required": ["camera_model"],
      "properties": {
        "camera_model": {"type": "string"},
        "lens": {"type": "string"}
      }
    }
  }
}
```

### Optional Fields with Defaults
```json
{
  "type": "object",
  "required": ["image_id"],
  "properties": {
    "image_id": {"type": "string"},
    "quality_checked": {"type": "boolean", "default": false},
    "notes": {"type": "string"}
  }
}
```

## Best Practices

- **Start simple**: Begin with basic required fields, add complexity gradually
- **Document your schema**: Include field descriptions and examples
- **Test thoroughly**: Validate your schema with sample data before deployment
- **Version your schemas**: Track changes when updating validation rules
- **Communicate changes**: Inform team members about new validation requirements

## Error Handling

When validation fails, you'll receive detailed error messages indicating:
- Which fields are missing
- Which fields have incorrect types
- Which extra fields are present (in strict mode)
- Exact location of the validation error in your JSON structure

This helps you quickly identify and fix metadata issues before successful upload.