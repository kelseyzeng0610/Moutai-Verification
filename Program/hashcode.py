import hashlib
import qrcode


#need to add more 
def generate_moutai_hash(date, place, special_id):
    # Concatenate the production date, place, and special id into a string
    production_info = f"{date}_{place}_{special_id}"
    
    # Convert the string to bytes and generate a SHA-256 hashcode
    hashcode = hashlib.sha256(production_info.encode()).hexdigest()
    
    # Return the hashcode
    return hashcode

#data  = generate_moutai_hash(xxx)


# Generate a QR code 
qr = qrcode.QRCode(version=1, box_size=10, border=5)

# Add the data to the QR code
qr.add_data(data)

# Generate the QR code image
qr.make(fit=True)
img = qr.make_image(fill_color="black", back_color="white")

# Save the QR code image to a file
img.save("qr_code.png")




